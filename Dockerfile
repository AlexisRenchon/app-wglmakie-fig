# Runs ubuntu commands 
FROM ubuntu

# Install wget and other
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y tar

# Downloads and install julia 
ENV JULIA_NAME "julia-1.9.0-beta2-linux-x86_64.tar.gz"
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/${JULIA_NAME} && \
    tar -xvzf ${JULIA_NAME} && \
    mv julia-1.9.0-beta2 /opt/ && \
    ln -s /opt/julia-1.9.0-beta2/bin/julia /usr/local/bin/julia && \
    rm ${JULIA_NAME}

# Copy Project.toml
COPY Project.toml ./Project.toml 

# Install dependencies
RUN julia --project -e "import Pkg; Pkg.instantiate(); Pkg.precompile()"

# Copy JSServe_app.jl
COPY JSServe_app.jl ./JSServe_app.jl

# Run the app
RUN julia --project -e 'include("JSServe_app.jl")'
