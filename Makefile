#生成可调式的可执行文件
CFLAGS := -g

#连接库如果是32位系统下编译出来的,在64位系统上进行编译要加上以下
XITONG := -m32

#在编译android固件时，出现过error: only position independent executables (PIE) are supported.
#需要在链接时添加上这个
PIE := -pie -fPIE

#链接库 其中-L. /bin 是在当前目录下寻找库，否则会在/use/lib/下找
LIBS := -lpthread -L./lib/ -lAirFlyReceiver \
        -lavahi-client \
        -lavahi-common \
        -ldaemon  \
        -lexpat \
        -lavahi-core \
        -ldbus-1

#要生成的可执行文件
PROGRAM :=Emulator
#要生成的.o文件
OBJ = Emulator.o

#指定编译工具
CC :=/usr/local/msdk-4.3.6-mips-EL-2.6.34-0.9.30.3/bin/mipsel-linux-g++

#all是一个伪目标，要是生成多个可执行文件时一定要有这个。
all: $(PROGRAM)

#编译可执行文件，生成一个可执行文件
$(PROGRAM) : $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

#生成多个可执行文件，目前是每个都写出来
#EmulatorReceiver : EmulatorReceiver.o
#	$(CC) $(XITONG) $(CFLAGS) -o $@ $^ $(LIBS)


#编译需要的.o文件
%.o:%.cpp
	$(CC) $(CFLAGS) -c $< -o $@

#删除编译出来的产物
clean:
	-rm -f $(OBJ) $(PROGRAM)
