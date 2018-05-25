#ifndef YAMPL_ZEROMQ_SOCKETFACTORY_H
#define YAMPL_ZEROMQ_SOCKETFACTORY_H

#include "yampl/ISocketFactory.h"
#include "yampl/plugin/PluginApi.h"
#include "yampl/plugin/IObject.hpp"

namespace zmq{
  class context_t;
}

namespace yampl
{
    namespace zeromq
    {
	yampl::plugin::IObject* HOOK_CreateObject(object_init_params*);
        hook_exec_status HOOK_DestroyObject(yampl::plugin::IObject*);

        class SocketFactory : public ISocketFactory
        {
            public:
                static const uint32_t __OBJECT_VERSION {0};

                SocketFactory();
                virtual ~SocketFactory();

                virtual ISocket *createClientSocket(Channel channel, Semantics semantics = COPY_DATA, void (*deallocator)(void *, void *) = defaultDeallocator, const std::string& name = DEFAULT_ID);
                virtual ISocket *createServerSocket(Channel channel, Semantics semantics = COPY_DATA, void (*deallocator)(void *, void *) = defaultDeallocator);

            private:
                zmq::context_t *m_context;

                SocketFactory & operator=(const SocketFactory &);
        };
    }
}

#endif
