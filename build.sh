#!/usr/bin/env sh

build_mode=$1
run=0

case $1 in
    debug)
        flags=" -debug -vet -strict-style"
        ;;
    release)
        flags=" -o:speed -vet -strict-style"
        ;;
    test)
        build_mode=debug
        flags=" -debug -vet -strict-style"
        run=1
        ;;
    *)
        error "Build mode\"$1\" unsupported!"
        exit 1
        ;;
esac

if [ ! -d "build" ]; then
    mkdir build
fi

if [ ! -d "build/$build_mode" ]; then 
    mkdir build/$build_mode
fi

odin build ./ -out:./build/$build_mode/game $flags

if [ $? != 0 ]; then 
    exit $?
fi

cp -v ./settings.ini ./build/$build_mode/settings.ini

if [ -d build/$build_mode/data ]; then
    rm -r ./build/$build_mode/data
fi
cp -r ./data ./build/$build_mode/data

if [ $? != 0 ]; then 
    exit $?
fi

if [ $run == 1 ]; then
    pushd build/$build_mode
        ./game
    popd
fi

