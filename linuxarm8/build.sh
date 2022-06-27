#! /usr/bin/env sh
	
SIGNER_DIR="$HOME/i2p-go-keys/"

wget -c -O monero-linuxarm8.tar.bz2 https://downloads.getmonero.org/cli/linuxarm8
mkdir -p monero-cli-linuxarm8
tar -xjf monero-linuxarm8.tar.bz2 -C monero-cli-linuxarm8 --strip-components=1

cp -v i2ptunnel.config monero-cli-linuxarm8
cp monero-cli-linuxarm8/monerod .
VERSION=$(../linux64/monero-cli-linux64/monerod --version | sed 's/.*(\(.*\))/\1/' -)
rm -vf client.yaml plugin.yaml
mkdir -p tmp/lib
cp -rv monero-cli-linuxarm8/* tmp/lib
cp ../i2ptunnel.config tmp/
i2p.plugin.native -name=monerod \
		-signer=hankhill19580@gmail.com \
		-signer-dir=$SIGNER_DIR \
		-version "$VERSION" \
		-author=hankhill19580@gmail.com \
		-autostart=true \
		-clientname=monerod \
		-consolename="Monero node over I2P" \
		-name="monerod-linuxarm8" \
		-delaystart="1" \
		-desc="Monero over I2P" \
		-exename=monerod \
		-updateurl="http://idk.i2p/railroad/monerod-linuxarm8.su3" \
		-website="http://idk.i2p/i2p.plugins.monero/" \
		-command="monerod --tx-proxy=127.0.0.1:7952 --anonymous-inbound \"*.i2p,127.0.0.1:18083,100\"" \
		-license=MIT \
		-res=./tmp/
