using JSServe
using parameterization_viz 
using ClimaLSM, ClimaLSM.Soil.Biogeochemistry

model_parameters = SoilCO2ModelParameters
model_functions = Dict("CO2 production" => (d1, d2, p) -> microbe_source(d1, d2, 5.0, p),
                       "CO2 diffusivity" => co2_diffusivity)
drivers_name = ["T_soil", "M_soil"]
drivers_limit = ([273, 303], [0.0, 0.5])

my_app = param_dashboard(model_parameters, model_functions, drivers_name, drivers_limit)

# my_app = App(DOM.div("hello world"))
server = JSServe.Server(my_app, "0.0.0.0", parse(Int, ENV["PORT"]))
#route!(server, "/" => App(DOM.div("hello world")))

wait(server)
