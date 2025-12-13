#!/bin/bash -e

repo=https://github.com/RooK-computer/keymaker.git

if [[ -d "${STAGE_WORK_DIR}/assistant" ]]; then
	rm -R "${STAGE_WORK_DIR}/assistant"
fi

GO_FILE="https://go.dev/dl/go1.25.5.linux-arm64.tar.gz"
GO_LOCAL="go1.25.5.linux-arm64.tar.gz"

if [[ ! -e "${STAGE_WORK_DIR}/$GO_LOCAL" ]]; then
	curl -L "${GO_FILE}" > "${STAGE_WORK_DIR}/$GO_LOCAL"
fi

if [[ ! -d "${STAGE_WORK_DIR}/go" ]]; then
	pushd "${STAGE_WORK_DIR}" >/dev/null
	tar xzf "$GO_LOCAL";
	popd >/dev/null
fi

git clone "$repo" "${STAGE_WORK_DIR}/assistant"
pushd "${STAGE_WORK_DIR}/assistant" >/dev/null
PATH="${STAGE_WORK_DIR}/go/bin:$PATH" make build
install -m 755 "${STAGE_WORK_DIR}/assistant/bin/keymaker" "${ROOTFS_DIR}/usr/bin"
popd >/dev/null

for script in ${STAGE_WORK_DIR}/assistant/scripts/*.sh; do
	install -m 755 "$script" "${ROOTFS_DIR}/usr/bin"
done

if grep keymaker "${ROOTFS_DIR}/home/rookie/.profile" >/dev/null || true ; then
	cat <<EOF >> "${ROOTFS_DIR}/home/rookie/.profile"

keymaker
EOF
fi


