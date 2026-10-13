#!/bin/zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKFLOW_NAME="画像縮小・JPEG化.workflow"
WORKFLOW_SOURCE="${SCRIPT_DIR}/config/automator/${WORKFLOW_NAME}"
WORKFLOW_DEST="${HOME}/Library/Workflows/Applications/Folder Actions/${WORKFLOW_NAME}"
FOLDER_PATH="${HOME}/Desktop/画像縮小"

STAGING_DIR="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-folder-actions.XXXXXX")"
trap 'rm -rf "$STAGING_DIR"' EXIT
cp -R "$WORKFLOW_SOURCE" "${STAGING_DIR}/${WORKFLOW_NAME}"
STAGED_WORKFLOW="${STAGING_DIR}/${WORKFLOW_NAME}"

# Automatorの保存先も、セットアップするMacのホームディレクトリに合わせる。
/usr/libexec/PlistBuddy -c "Set :workflowMetaData:folderActionFolderPath ${FOLDER_PATH}" \
    "${STAGED_WORKFLOW}/Contents/document.wflow"

# 既存のワークフローが異なる場合は、更新前にバックアップする。
if [[ -f "${WORKFLOW_DEST}/Contents/document.wflow" ]] && \
   { ! cmp -s "${STAGED_WORKFLOW}/Contents/document.wflow" "${WORKFLOW_DEST}/Contents/document.wflow" || \
     ! cmp -s "${STAGED_WORKFLOW}/Contents/Info.plist" "${WORKFLOW_DEST}/Contents/Info.plist"; }; then
    BACKUP_DIR="$(mktemp -d "${WORKFLOW_DEST}.backup.$(date +%Y%m%d%H%M%S).XXXXXX")"
    cp -R "${WORKFLOW_DEST}/." "$BACKUP_DIR"
fi
mkdir -p "$FOLDER_PATH" "${WORKFLOW_DEST}/Contents"
cp "${STAGED_WORKFLOW}/Contents/Info.plist" "${WORKFLOW_DEST}/Contents/Info.plist"
cp "${STAGED_WORKFLOW}/Contents/document.wflow" "${WORKFLOW_DEST}/Contents/document.wflow"

/usr/bin/osascript "${SCRIPT_DIR}/config/automator/register-folder-action.applescript" \
    "$FOLDER_PATH" "$WORKFLOW_DEST"
echo "${FOLDER_PATH}: 1024pxへのサイズ調整・JPEG変換を登録しました"
