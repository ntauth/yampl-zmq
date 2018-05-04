#################################
# YAMPL-ZMQ
#################################
if (WITH_ZMQ_PLUGIN STREQUAL ON)
    message(STATUS "[PLUGIN] Including yampl-zmq")
	    
    add_library(yampl-zmq SHARED
	    plugins/yampl-zmq/src/ClientSocket.cpp
            plugins/yampl-zmq/src/ServerSocket.cpp
            plugins/yampl-zmq/src/SocketBase.cpp
            plugins/yampl-zmq/src/SocketFactory.cpp
            ${YAMPL_PLUGIN_COMMON_SRCS}
    )

    target_include_directories(yampl-zmq PRIVATE plugins/yampl-zmq/include)

    set_target_properties(yampl-zmq PROPERTIES SUFFIX ".yam")
    set_target_properties(yampl-zmq
            PROPERTIES
            ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/plugins/yampl-zmq"
            LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/plugins/yampl-zmq"
            RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/plugins/yampl-zmq"
    )
    add_dependencies(yampl-zmq LibSourcey)

    install(TARGETS yampl-zmq
            LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/yampl/plugins/yampl-zmq
    )
endif()
