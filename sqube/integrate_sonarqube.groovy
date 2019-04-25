// This Jenkins job deploys the sonarqube
import com.flux7.dslfactory.*
def deploystack = new PipelineJobFactory(this)
git_url = GIT_URL
git_branch = GIT_BRANCH
job_name = "test-sonarqube"
job_path = "${new File(__FILE__).parent}"
def jenkinsfile  = "jobs/tests/test-sonarqube/Jenkinsfile"

pipelineJob(job_name) 
{
  description("Jenkins pipeline job to integrate SonarQube")
  logRotator(-1,100)
  parameters 
  {
    stringParam("SONAR_PROJECT_NAME", '', description="Name of the project for addition to SonarQube")
    stringParam("GIT_URL", git_url, description="GIT URL of the repo to be added to sonarqube")
    stringParam("GIT_BRANCH", git_branch, description="GIT Branch of the repo to be added to sonarqube")


  }
  logRotator(numToKeep = 100)
    definition {
        cps {
            sandbox()
            script(readFileFromWorkspace(jenkinsfile))
        }
    }
}
