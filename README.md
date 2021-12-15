# Airbnb-Home-Clone

2021년도 2학기 두드림 프로젝트 결과물

## 프로젝트 설명

에어비앤비를 클론 코딩하는 프로젝트입니다. 각각의 팀원이 iOS 네이티브, Android 네이티브 앱을 구현하였습니다. 구글의 Firebase를 활용하여 기존 에어비앤비의 몇가지 대표적인 기능들을 축소 구현하였으며, View 역시 단순화 하였습니다. 

현재 repository 는 iOS 네이티브 클론 코딩의 프로젝트 폴더이며, 팀원이 진행한 안드로이드 프로젝트 폴더의 깃허브 주소는 첨부할 예정입니다.

## 실행화면

## View Hierarchy

storyboard 를 활용하지 않고, programmatically 하게 구현하였습니다. 

- SceneDelegate.swift

클래스 내부에서 window 를 UIWindow 의 인스턴스로 활용하여, scene 을 구성하였습니다.

- AppController.swift

NotificationCenter 에 AuthDidChange 와 관련한 observer 를 추가

### AppController class dptj

## Firebase

Firebase 를 활용하여 기존 앱의 여러가지 기능을 구현하였습니다.

FireStore, FireRealtimeDatabase, Cloud Messaging
