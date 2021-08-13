#!/bin/bash

mkdir -p "${HOME}/.ssh"
gpg --quiet --batch --yes --decrypt --passphrase=${AVN_GPG_PASSWORD} --output .github/avereon.keystore .github/avereon.keystore.gpg
gpg --quiet --batch --yes --decrypt --passphrase=${AVN_GPG_PASSWORD} --output $HOME/.ssh/id_rsa .github/id_rsa.gpg
gpg --quiet --batch --yes --decrypt --passphrase=${AVN_GPG_PASSWORD} --output $HOME/.ssh/id_rsa.pub .github/id_rsa.pub.gpg
gpg --quiet --batch --yes --decrypt --passphrase=${AVN_GPG_PASSWORD} --output $HOME/.ssh/known_hosts .github/known_hosts.gpg
chmod 600 "${HOME}/.ssh/id_rsa"
chmod 600 "${HOME}/.ssh/id_rsa.pub"
chmod 600 "${HOME}/.ssh/known_hosts"

#AVN_RELEASE is derived from GITHUB_REF, example values: refs/heads/main, refs/heads/stable
case "${GITHUB_REF}" in
  "refs/heads/main") AVN_RELEASE="latest" ;;
  "refs/heads/stable") AVN_RELEASE="stable" ;;
esac

export JAVA_DISTRO='adopt'
export JAVA_PACKAGE='jdk'
export PRODUCT_DEPLOY_PATH=/opt/avn/store/${AVN_RELEASE}/${AVN_PRODUCT}

echo "Build date=$(date)"
echo "GITHUB_REF=${GITHUB_REF}"
echo "PRODUCT_DEPLOY_PATH=${PRODUCT_DEPLOY_PATH}"

echo "JAVADOC_DEPLOY_PATH=/opt/avn/store/latest/${AVN_PRODUCT}" >> $GITHUB_ENV
echo "JAVADOC_TARGET_PATH=/opt/avn/web/product/${AVN_PRODUCT}/javadoc" >> $GITHUB_ENV
echo "PRODUCT_DEPLOY_PATH=${PRODUCT_DEPLOY_PATH}" >> $GITHUB_ENV
