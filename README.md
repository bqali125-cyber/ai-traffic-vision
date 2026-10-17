# AI Traffic Vision

Real-time traffic computer vision platform for vehicle detection, multi-object tracking, speed estimation, and Iranian license plate recognition.

## Overview

AI Traffic Vision is a modular computer vision system designed for real-time traffic monitoring and intelligent vehicle analysis.

The platform combines object detection, multi-object tracking, perspective-based speed estimation, license plate recognition, and a web-based monitoring interface into a single pipeline.

> This project is intended for research, engineering, and computer vision experimentation. Detection and recognition results should not be treated as legally authoritative evidence without appropriate validation and certification.

## Key Capabilities

- Real-time vehicle detection
- Multi-object tracking with ByteTrack
- Persistent vehicle identity tracking
- License plate detection and recognition
- Perspective-aware speed estimation
- Real-time traffic monitoring
- Web-based monitoring interface
- Automated installation and verification scripts
- Automated testing with pytest
- GPU acceleration where supported

## Architecture

```text
Video / Camera
      │
      ▼
┌─────────────────────┐
│   Frame Acquisition │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ Vehicle Detection   │
│      YOLOv8         │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ Multi-Object        │
│ Tracking / ByteTrack│
└──────────┬──────────┘
           │
      ┌────┴─────┐
      ▼          ▼
 Speed        License Plate
Estimation     Recognition
      │          │
      └────┬─────┘
           ▼
┌─────────────────────┐
│ Traffic Analytics   │
│ & Event Processing  │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ Web Monitoring UI   │
└─────────────────────┘
