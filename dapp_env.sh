#!/usr/bin/env sh


case "$(uname -s)" in
   CYGWIN*|MINGW32*|MSYS*|MINGW*)
	 OS_FILECONFIG=conf.window.yaml
     ;;

   *)
	# Linux or Darwin 
     OS_FILECONFIG=conf.linux.yaml
     ;;
esac

# Set environment variables for the dapp
export HLF_DAPP_CONFIG="${PWD}/dapp/${OS_FILECONFIG}"
export HLF_DAPP_JWT_SIGN_KEY="45567f001601aacb761e13987cddc62ddd49c5b2"