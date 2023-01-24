using JSServe

server = JSServe.Server(my_app, "0.0.0.0", parse(Int, ENV["PORT"]))
route!(server, "/" => App(DOM.div("hello world")))

wait(server)
