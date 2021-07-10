[![gitstars](https://img.shields.io/github/stars/SpaceWorksCo/spacecoin?style=social)](https://github.com/SpaceWorksCo/spacecoin/stargazers)
[![twitter](https://img.shields.io/twitter/follow/SpacecoinSPACE?style=social)](https://twitter.com/SpacecoinSPACE)
[![discord](https://img.shields.io/discord/701937565929963581)](https://spaceworks.co/discord)

---
![Spacecoin Logo](https://i.imgur.com/FlGoFAz.png "Spacecoin Logo")


## Spacecoin (SPACE)

This is the official Spacecoin source code repository based on [KomodoPlatform/Komodo](https://github.com/KomodoPlatform/komodo).

## Resources

- Website: [spacecoin.network](https://spacecoin.network/)
- Block Explorer: [spacecoinexplorer.com](https://spacecoinexplorer.com)
- Discord: [spacecoin.network/discord](https://spacecoin.network/discord)
- Mail: [hello@spacecoin.network](mailto:hello@spacecoin.network)
- Support: The `#support` channel on the [Spacecoin Discord](https://spacecoin.network/discord)

## Tech Specification
- Max Supply: 5,898,454,281 SPACE
- Block Time: 30 seconds
- Block Reward: 36 SPACE (currently)
- Block Generation: 50% PoW | 50% PoS
- Mining Algorithm: Equihash (200, 9)

## Getting started

### Dependencies

```shell
#The following packages are needed:
sudo apt-get install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python python-zmq zlib1g-dev wget libcurl4-gnutls-dev bsdmainutils automake curl libsodium-dev
```

### Build Spacecoin

This software is based on zcash and considered experimental and is continuously undergoing development.

The dev branch is considered the bleeding edge codebase while the master-branch is considered tested (unit tests, runtime tests, functionality). At no point of time does the SpaceWorks team take any responsibility for any damage out of the usage of this software.
Spacecoin builds for all operating systems out of the same codebase. Follow the OS specific instructions from below.

#### Linux
```shell
#Install dependencies:
sudo apt-get install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python python-zmq zlib1g-dev wget libcurl4-gnutls-dev bsdmainutils automake curl libsodium-dev
# Clone the spacecoin repo
git clone https://github.com/SpaceWorksCo/spacecoin --branch master --single-branch
# Change master branch to other branch you wish to compile
cd spacecoin
./zcutil/fetch-params.sh
./zcutil/build.sh -j4
# Change -j4 to specify the number of cores to use. ex: -j2
# This can take some time.
```


#### OSX
Ensure you have [brew](https://brew.sh) and Command Line Tools installed.
```shell
# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# Install Xcode, opens a pop-up window to install CLT without installing the entire Xcode package
xcode-select --install
# Update brew and install dependencies
brew update
brew upgrade
brew tap discoteq/discoteq; brew install flock
brew install autoconf autogen automake
brew update && brew install gcc@8
brew install binutils
brew install protobuf
brew install coreutils
brew install wget
# Clone the spacecoin repo
git clone https://github.com/SpaceWorksCo/spacecoin --branch master --single-branch
# Change master branch to other branch you wish to compile
cd spacecoin
./zcutil/fetch-params.sh
./zcutil/build-mac.sh -j$(expr $(sysctl -n hw.ncpu) - 1)
# This can take some time.
```

#### Windows
Use a debian cross-compilation setup with mingw for windows and run:
```shell
#Install dependencies:
sudo apt-get install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python python-zmq zlib1g-dev wget libcurl4-gnutls-dev bsdmainutils automake curl cmake mingw-w64 libsodium-dev libevent-dev
#Install rust targeting x86_64-pc-windows
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
rustup target add x86_64-pc-windows-gnu

sudo update-alternatives --config x86_64-w64-mingw32-gcc
# (configure to use POSIX variant)
sudo update-alternatives --config x86_64-w64-mingw32-g++
# (configure to use POSIX variant)

#Clone the spacecoin repo
git clone https://github.com/SpaceWorksCo/spacecoin --branch master --single-branch
# Change master branch to other branch you wish to compile
cd spacecoin
./zcutil/fetch-params.sh
./zcutil/build-win.sh -j$(expr $(nproc) - 1)
#This can take some time.
```
**spacecoin is experimental and a work-in-progress.** Use at your own risk.

To reset the Spacecoin blockchain change into the *~/.komodo/SPACE* data directory and delete the corresponding files by running `rm -rf blocks chainstate debug.log komodostate db.log`

#### Create SPACE.conf

Create a SPACE.conf file:

```
mkdir ~/.komodo/SPACE
cd ~/.komodo/SPACE
touch SPACE.conf

#Add the following lines to the SPACE.conf file:
rpcuser=yourrpcusername
rpcpassword=yoursecurerpcpassword
rpcbind=127.0.0.1
txindex=1
addnode=165.227.35.158
addnode=167.172.39.135
addnode=165.22.64.156
addnode=188.166.221.247
addnode=164.90.145.140

```

License
-------
For license information see the file [COPYING](COPYING).

**NOTE TO EXCHANGES:**
https://bitcointalk.org/index.php?topic=1605144.msg17732151#msg17732151
There is a small chance that an outbound transaction will give an error due to mismatched values in wallet calculations. There is a -exchange option that you can run spacecoind with, but make sure to have the entire transaction history under the same -exchange mode. Otherwise you will get wallet conflicts.

**To change modes:**

a) backup all privkeys (launch spacecoind with `-exportdir=<path>` and `dumpwallet`)  
b) start a totally new sync including `wallet.dat`, launch with same `exportdir`  
c) stop it before it gets too far and import all the privkeys from a) using `spacecoin-cli importwallet filename`  
d) resume sync till it gets to chaintip  

For example:
```shell
./spacecoind -exportdir=/tmp &
./spacecoin-cli dumpwallet example
./spacecoin-cli stop
mv ~/.komodo/SPACE ~/.komodo/SPACE.old && mkdir ~/.komodo/SPACE && cp ~/.komodo/SPACE.old/komodo.conf ~/.komodo/SPACE.old/peers.dat ~/.komodo/SPACE
./spacecoind -exchange -exportdir=/tmp &
./spacecoin-cli importwallet /tmp/example
```
---


Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
