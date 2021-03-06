#ifndef SHARDFREE_LOG_WRITER_WEBSOCKET_H_
#define SHARDFREE_LOG_WRITER_WEBSOCKET_H_

// Writes logs out to a websocket server.

#include <string>
#include "zmq.hpp"

#include "thread.h"

namespace ShardFree
{

//
// Outputs logs from the logger asynchronously on a separate thread.
//
class LogWriterWebsocket : public Thread
{
  public:
    LogWriterWebsocket(const std::string &publisher_name = "inproc://logpub", const int port = 7890);
    virtual ~LogWriterWebsocket();

  protected:
    /*virtual*/ void init();
    /*virtual*/ void run();

  private:
    std::string mPublisherName;
    zmq::socket_t *mPublisherp;
    int mPort;
};

}

#endif // SHARDFREE_LOG_WRITER_WEBSOCKET_H_