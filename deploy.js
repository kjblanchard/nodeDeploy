var shell = require('shelljs')

function DeployQuoteGen(imageId, deploymentName, r53Change, websiteName) {

    if (!shell.which('terraform') || !shell.which('kubectl') || !shell.which('helm'))
        return null

        shell.cd('./terraform/deployQuoteGen')
        shell.exec('terraform init -input=false')
        shell.exec('terraform plan -out=tfplan -input=false')
        //Send to DB that it has been started
        shell.exec('terraform apply -input=false tfplan')
        //Send to DB that it has been created
        shell.exec('terraform destroy -auto-approve')
        //Send to DB that it has been destroyed
}
module.exports = {DeployQuoteGen}