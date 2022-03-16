#!/bin/bash
# production

# 定数の定義
MYSQL_SCHEMA="db"
ROOT_DIRECTORY="/var/tmp"
CMD_MYSQL="mysql --defaults-extra-file=$ROOT_DIRECTORY/mysql.conf -t --show-warnings $MYSQL_SCHEMA"
LOG_NAME=${ROOT_DIRECTORY}/mysql-sh.log
# 実行時間の取得
PID=$$_`date '+%H%M%S'`
# ログ出力
exec 1> >(awk '{print strftime("[%Y-%m-%d %H:%M:%S]") "[""'$PID'""]" $0} {fflush()} ' >>$LOG_NAME)
exec 2> >(awk '{print strftime("[%Y-%m-%d %H:%M:%S]") "[""'$PID'""]" $0} {fflush()} ' >>$LOG_NAME)

function selectQuery() {
    local QUERY="SELECT id FROM sample_table"
    local VALUE
    VALUE=`echo ${QUERY} | ${CMD_MYSQL}`
    if [[ $? -eq 0 ]]; then
        echo "[INFO] server mode maintenance"
        return 0
    else
        echo "[ERROR] server mode not maintenance : ${VALUE}"
        return 1
    fi
}

# 結果のチェック
function checkResult() {
    if [ $1 -eq 1 ]; then
        echo "[ERROR] $0 abnormal 終了"
        exit 1
    elif [ $1 -eq 2 ]; then
        echo "[INFO] $0 終了"
        exit 0
    fi
}

# 実際の処理開始
echo "[INFO] $0 開始"

selectQuery; checkResult $?

echo "[INFO] $0 終了"