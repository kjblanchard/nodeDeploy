FROM node:16-alpine3.11
ENV platform=develop
#This is needed for getting helm and avoiding the ssl check
ENV VERIFY_CHECKSUM=false
ENV TERRAFORM_VERSION=1.0.3 

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app



RUN apk --update --no-cache add libc6-compat git openssh-client python py-pip python3 && pip install awscli
RUN apk update && apk add gnupg curl
RUN cd /usr/local/bin && \
    curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN curl -LO https://dl.k8s.io/release/v1.22.0/bin/linux/amd64/kubectl
RUN chmod +x kubectl
RUN mkdir -p ~/.local/bin/kubectl
RUN mv ./kubectl ~/.local/bin/kubectl
RUN export PATH=~/.local/bin/kubectl:$PATH
RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | sh
COPY . .
RUN mkdir -p ~/.aws
RUN mv credentials ~/.aws/.
RUN npm install

EXPOSE 3001

CMD ["npm", "run", "start"]
