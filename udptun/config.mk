CPPFLAGS += -pedantic -Wall -W -Wno-unused-parameter
CPPFLAGS += -g

CFLAGS += -O3
CFLAGS += -std=gnu11

CXXFLAGS += -O2
CXXFLAGS += -std=gnu++17

CPPFLAGS += -D_XOPEN_SOURCE=600
CPPFLAGS += -D_GNU_SOURCE=1
CPPFLAGS += -Wno-missing-field-initializers

#CPPFLAGS += -DWITH_STRERROR_NP
#CPPFLAGS += -DWITH_SIGNAMES

udptun_lib += -lstdc++fs -lanl
