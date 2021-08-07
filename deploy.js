var shell = require('shelljs')
const axios = require('axios').default;
const url = "http://localhost:3000/api/deployments"

function DeployQuoteGen(imageId, deploymentName, r53Change, websiteName) {

    if (!shell.which('terraform') || !shell.which('kubectl') || !shell.which('helm'))
        return null

    let newDeployment = ''
    console.log('Initializing Terraform')
    shell.cd('./terraform/deployQuoteGen')
    shell.exec('terraform init -input=false')
    console.log('Planning terraform, this could be reviewed by a person, will cat out at the end')
    shell.exec('terraform plan -out=tfplan -input=false')
    axios.post(url, {
        deploymentName: `${deploymentName}`,
        imageName: `${imageId}`,
        status: 'Deploying'
    })
        .then(function (response) {
            console.log('Here is the plan that is going to be applied')
            const { stdout, stderr, code } = shell.exec('terraform show tfplan', { silent: true })
            console.log(stdout)
            shell.exec('terraform apply -input=false tfplan')
            newDeployment = response.data.response
            console.log(response.data)
            axios.put(url, {
                imageName: `${imageId}`,
                deploymentName: `${deploymentName}`,
                status: 'Deployed',
                id: `${newDeployment}`
            })
                .then(function (response) {
                    console.log(response.data)
                    console.log('Destroying cause this is a test')
                    shell.exec('terraform destroy -auto-approve')
                    axios.put(url, {
                        imageName: `${imageId}`,
                        deploymentName: `${deploymentName}`,
                        status: 'Destroyed',
                        id: `${newDeployment}`
                    })
                        .then(response => {
                            console.log(response.data)
                        })
                        .catch((error) => handleError(error, newDeployment, deploymentName, imageName))
                })
                .catch((error) => handleError(error, newDeployment, deploymentName, imageName))
        })
        .catch((error) => handleError(error, newDeployment, deploymentName, imageName))
}

function handleError(error, idToUpdate, deploymentName, imageName) {
    console.log(error)
    if (idToUpdate) {
        axios.put(url, {
            imageName: `${imageId}`,
            deploymentName: `${deploymentName}`,
            status: 'Error Deploying',
            id: `${newDeployment}`
        })
            .then((response) => {
                console.log(response)
            })
            .catch((error) => {
                console.log(error)
                console.log('Failed to update db')
            })
    }
}

module.exports = { DeployQuoteGen }