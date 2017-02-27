# Zintow Content Summary data Support Solution Review Deployment Scripts .test

pipeline

node ('c3s_release_deploy'){
   // Mark the code checkout 'stage'....
   stage 'Checkout'

   // Get some code from a GitHub repository
    git([url: 'http://git.zintow.com:10080/deployment/csss.git', branch: 'master'])


   // Mark the code build 'stage'....
   stage 'rm csss container'
   // Run the build
   sh "docker-compose stop && docker-compose rm -f"
   sh "systemctl restart iptables"
   
   stage 'docker pull images'
   sh "docker-compose pull"
   
    // Mark the code run 'stage'....
   stage 'Run csss containers'
   // Run the program
   sh "docker-compose up -d"
   sh "sh ipd.sh"
   
   stage 'config c3s data'
   sh "sh service_consul.sh"
   sh "sh config_consul.sh"
}
