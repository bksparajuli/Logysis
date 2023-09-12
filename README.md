# Logysis
Lightweight SIEM solution for small organization

## Overview

This repository contains the source code and documentation for my Security Information and Event Management (SIEM) project. The SIEM system is designed to enhance security monitoring, log analysis, and threat detection using Elasticsearch, Logstash, Kibana, Fail2ban, Suricata, and Slack integration.

## Features

- Real-time log collection from various sources.
- Log parsing and normalization for different log formats.
- Integration with Fail2ban and Suricata for threat detection.
- Custom parsers and rules for specialized log data.
- Visualization of security events using Kibana dashboards.
- Alerting and notification through Slack for immediate action.
- Scalability to handle growing log data volumes.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Docker installed on your system.
- Configuration files for each component (Elasticsearch, Logstash, Kibana, etc.).
- Access to relevant log sources and network devices.

## Installation

1. Clone this repository to your local machine.
2. Configure the necessary environment variables and settings in the provided configuration files.
3. Build and run the Docker containers for Elasticsearch, Logstash, Kibana, and other components.

## Usage

1. Start the SIEM system using Docker Compose.
2. Access Kibana's web interface to create visualizations and dashboards.
3. Monitor incoming logs, security events, and alerts.
4. Configure Slack integration for real-time notifications.

