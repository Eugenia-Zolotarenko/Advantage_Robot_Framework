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
        stage('Purchase Flow') {
            steps {
                bat "C:\\QA\\AdvantageProject\\.venv\\Scripts\\robot.exe -d Output\\ -v BROWSER:${params.BROWSER} --randomize tests C:\\QA\\AdvantageProject\\TestCases\\Purchase_Flow_Three_Products.robot"
            }
        }
        stage('Generate Keyword Docs') {
            steps {
                bat """
                    if not exist C:\\QA\\AdvantageProject\\docs mkdir C:\\QA\\AdvantageProject\\docs
                    for %f in (C:\\QA\\AdvantageProject\\Resources\\*_Keywords.robot) do C:\\QA\\AdvantageProject\\.venv\\Scripts\\python.exe -m robot.libdoc "%f" "C:\\QA\\AdvantageProject\\docs\\%%~nf.html"
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
