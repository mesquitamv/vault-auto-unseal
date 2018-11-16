node('docker') {
    checkout scm
    stage('Create docker image') {
        wrap([$class: 'VaultBuildWrapper', 
                configuration: [$class: 'VaultConfiguration',
                    vaultCredentialId: 'vault-token-service-readonly'
                ], 
                vaultSecrets: [
                    [$class: 'VaultSecret', path: 'services/external/production/hub.docker.com/engpro', secretValues: [
                        [$class: 'VaultSecretValue', envVar: 'DOCKERUSER', vaultKey: 'username'],
                        [$class: 'VaultSecretValue', envVar: 'DOCKERPASS', vaultKey: 'password']
                    ]],
                ]]) {
            sh '''
            docker login -u ${DOCKERUSER} -p ${DOCKERPASS}
            docker build -t totvsengpro/vault-auto-unseal .
            docker push totvsengpro/vault-auto-unseal
            '''
        }  
    }
}