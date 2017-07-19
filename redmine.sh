#!/bin/sh

read -d '' data << EOF
<?xml version="1.0"?>
<issue>
  <subject>Delete/Remove Project</subject>
  <description>The user can remove a project from the list with or without deleting it on disk</description>
  <parent_issue_id>2762</parent_issue_id>
  
  <project_id>2</project_id>
  <priority_id>2</priority_id>
  <tracker_id>6</tracker_id>
  <status_id>1</status_id>
  <assigned_to_id><YOUR_USER_ID></assigned_to_id>
</issue>
EOF

echo $data | curl -k --request POST --header "Content-type: application/xml" --data-binary @- https://dev.rdit.ch/issues.json?key=<YOUR_API_KEY>
