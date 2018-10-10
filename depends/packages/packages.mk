ifneq ($(host_arch), aarch64)
 rust_packages := rust librustzcash
endif

zcash_packages := libsnark libgmp libsodium

ifeq ($(build_os),darwin)
	zcash_packages := libsnark libgmp libsodium
else
#	proton_packages := proton
	zcash_packages := libgmp libsodium
endif

ifeq ($(host_os),linux)
	packages := boost openssl libevent zeromq $(zcash_packages) googletest #googlemock
else
	packages := boost openssl libevent zeromq $(zcash_packages) libcurl googletest #googlemock
endif

native_packages := native_ccache

wallet_packages=bdb
