pipeline {
    agent any

    triggers {
        cron('0 2 * * *')
    }

    parameters {
        choice(
            name: 'BROWSER',
            choices: ['headlesschrome', 'headlessfirefox', 'chrome', 'firefox', 'edge'],
            description: 'Browser to run tests in'
        )
    }

    stages {
        stage('Setup') {
            steps {
                bat """
                    if not exist .venv py -m venv .venv
                    .venv\\Scripts\\pip.exe install -r requirements.txt
                """
            }
        }
        stage('Purchase Flow') {
            steps {
                bat ".venv\\Scripts\\robot.exe -d Output\\ -v BROWSER:${params.BROWSER} --randomize tests TestCases\\Purchase_Flow_Three_Products_From_File.robot"
            }
        }
        stage('Generate Keyword Docs') {
            steps {
                bat """
                    if not exist docs mkdir docs
                    for %f in (Resources\\*_Keywords.robot) do .venv\\Scripts\\python.exe -m robot.libdoc "%f" "docs\\%%~nf.html"
                """
            }
        }
    }

    post {
        always {
            robot(
                outputPath: 'Output',
                passThreshold: 90.0,
                unstableThreshold: 75.0
            )
        }
        failure {
            echo 'Tests failed — check the Robot Framework report'
        }
        success {
            echo 'All tests passed'
        }
    }
}
