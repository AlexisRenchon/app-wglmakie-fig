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

ENV mainpath ./
RUN mkdir -p ${mainpath}

USER ${NB_USER}

ENV USER_HOME_DIR /home/${NB_USER}
ENV JULIA_PROJECT ${USER_HOME_DIR}
ENV JULIA_DEPOT_PATH ${USER_HOME_DIR}/.julia

# Copy files
COPY Project.toml ${mainpath}/Project.toml 
COPY JSServe_app.jl ${mainpath}/JSServe_app.jl

# Install deps
RUN julia --project=${mainpath} -e "import Pkg; Pkg.instantiate(); Pkg.precompile()"

# Run apps
CMD julia --project=${mainpath} -e 'include("JSServe_app.jl")'
