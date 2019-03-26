// This Jenkins job deploys the sonarqube
git_url = GIT_URL
git_branch = GIT_BRANCH
cf_git_url = CF_GIT_URL
cf_git_branch = CF_GIT_BRANCH
job_name = "deploy-sonarqube"
job_path = "${new File(__FILE__).parent}"
def jenkinsfile  = "jobs/deploy-sonarqube/Jenkinsfile"

pipelineJob(job_name) 
{
  description("Jenkins pipeline job to deploy SonarQube")
  logRotator(-1,100)
  parameters 
  {
    stringParam("GIT_URL", git_url, description="GIT URL of repo containing ansible playbook for sonarqube")
    stringParam("GIT_BRANCH", git_branch, description="GIT Branch of repo containing anisble playbook")
  }
  logRotator(numToKeep = 100)
    definition {
        cps {
            sandbox()
            script(readFileFromWorkspace(jenkinsfile))
        }
    }
}
