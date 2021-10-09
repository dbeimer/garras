pipeline{
  agent any
  /* tools { */
    
  /* } */
  options {
    timeout(time:2,unit: 'MINUTES')
  }

  stages{
    stage('going to the folder'){
      steps{
        sh 'cd build'
      }
    }

    stage('stage 2'){
      steps {
        sh 'ls -l'
      }
    }
  }
}
