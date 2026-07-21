#ifndef PC_DRIVER_MESSAGE
#define PC_DRIVER_MESSAGE

#include <cstdint>
#include "data_structures.h"

// Configuration
constexpr size_t txMsgSize = sizeof(sentMessage_t);
constexpr size_t rxMsgSize = sizeof(receivedMessage_t);

// Message variables
extern sentMessage_t txMsg;
extern receivedMessage_t rxMsg;

#endif //PC_DRIVER_MESSAGE
