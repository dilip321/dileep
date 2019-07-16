resource "aws_cloudwatch_metric_alarm" "es-master-1-cpu" {
  alarm_name          = "test-name-cpu-utilization"
  namespace           = "AWS/EC2"
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Average"
  alarm_description   = "This metric records cpu utilization of es master 1 instance"
  comparison_operator = "GreaterThanThreshold"
  threshold           = "80"
  metric_name         = "CPU Utilization ES-M1"
  dimensions {
    InstanceId = "i-04c12e34f1f70f28c"
  }
}

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "my-dashboard"

  dashboard_body = <<EOF
 {
   "widgets": [
       {
          "type":"metric",
          "x":0,
          "y":0,
          "width":12,
          "height":6,
          "properties":{
             "metrics":[
                [
                   "AWS/EC2",
                   "CPUUtilization",
                   "InstanceId",
                   "i-04c12e34f1f70f28c"
                ]
             ],
             "period":300,
             "stat":"Average",
             "region":"eu-west-1",
             "title":"EC2 Instance CPU"
          }
       },
       {
          "type":"text",
		   "x":0,
          "y":7,
          "width":3,
          "height":3,
          "properties":{
             "markdown":"Hello world"
          }
       }
   ]
 }
 EOF
}


