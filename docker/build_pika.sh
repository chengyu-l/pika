#! /bin/bash

ROOT_PATH=$(cd $(dirname $0)/..; pwd)
PIKA_DIR=/pika
BUILD_TYPE=RelWithDebInfo

help() {
    echo "Usage: ./build_pika.sh [-b] [-c] [--help]"
    echo ""
    echo "Options:"
    echo "  -b                   build pika"
    echo "  -o                   build codis"
    echo "  -c                   clean build output "
    echo "  --help               help"
    echo ""
    echo "eg:"
    echo "  ./build_pika.sh -b "
    echo "  ./build_pika.sh -o "
    echo "  ./build_pika.sh -c "
    exit 0
}

clean_build() {
    docker run -i --rm  -v ${ROOT_PATH}:/pika -h pika_build --privileged --name pika_build pika/pika_build:v0.1 /bin/bash -c "cd ${PIKA_DIR}/output && make clean"
}

build_pika() {
    docker run -i --rm  -v ${ROOT_PATH}:/pika -h pika_build --privileged --name pika_build pika/pika_build:v0.1 /bin/bash -c "./build.sh"
}

build_codis() {
    docker run -i --rm  -v ${ROOT_PATH}:/pika -h pika_build --privileged --name pika_build pika/pika_build:v0.1 /bin/bash -c "cd ${PIKA_DIR}/codis/ && make"
}

cmd="help"

while getopts "boc-:" opt; do
  case $opt in
    b)
      cmd=build_p
      ;;
    c)
      cmd=clean
      ;;
    o)
      cmd=build_c
      ;;
    -)
      case $OPTARG in
        help)
          cmd=help
          ;;
        *)
          echo "Unknown option --$OPTARG"
          exit 1
          ;;
      esac
      ;;
    *)
      echo "Unknown option -$opt"
      exit 1
      ;;
  esac
done


case "-$cmd" in
    -build_p) build_pika ;;
    -build_c) build_codis ;;
    -clean) clean_build ;;
    -help) help ;;
    *) help ;;
esac



