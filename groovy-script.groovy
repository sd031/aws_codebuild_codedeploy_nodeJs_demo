import jenkins.*;
import jenkins.model.*;

// CONFIGURATION
// Links between changed file patterns and job names to build
def jobsByPattern = [
  "/my-project/": "my-project-job",
  "my-super-project/":"super-job",
]

// Listing changes files since last build
 println "Starting script"
def changeLogSets = build.changeSets
def changedFiles = []
for (int i = 0; i < changeLogSets.size(); i++) {
   def entries = changeLogSets[i].items
   for (int j = 0; j < entries.length; j++) {
    def entry = entries[j]
    def files = new ArrayList(entry.affectedFiles)
    for (int k = 0; k < files.size(); k++) {
       def file = files[k]
         println "File from changeLogSet entry: $file"

       changedFiles.add(file.path)
    }
  }
}

// Listing ad hoc jobs to build
jobsToBuild = [:] // declare an empty map
for(entry in jobsByPattern ) {
  def pattern = entry.key
  println "Check pattern: $pattern"
  for (int i = 0; i < changedFiles.size(); i++) {
    def file = changedFiles[i]
    println "Check file: $file"
    if( file.contains( pattern ) ) {
      def jobName = entry.value
      jobsToBuild[ jobName ] = true
      break
    }
  }
}