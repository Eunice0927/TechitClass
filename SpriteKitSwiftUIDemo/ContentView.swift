//
//  ContentView.swift
//  SpriteKitSwiftUIDemo
//
//  Created by 박준영 on 1/18/24.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    // 향후 게임이 위치하게 될 개체를 호스팅할 변수
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 216, height: 216)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            // SpriteKit 장면을 렌더링하는 SwiftUI 뷰
            // https://developer.apple.com/documentation/spritekit/spriteview?ref=createwithswift.com
            SpriteView(scene: self.scene)
                .frame(width: 256, height: 256)
                .ignoresSafeArea()
        }
        .padding()
    }
}

// 테스트를 위해 게임 장면이 화면에 나타났다는 간단한 메시지만 출력
class GameScene: SKScene {
    override func didMove(to view: SKView) {
        print("You are in the game scene!")
        // 노드에 물리 시뮬레이션을 추가하는 객체
        // https://developer.apple.com/documentation/spritekit/skphysicsbody
        // https://developer.apple.com/documentation/spritekit/sknode/getting_started_with_physics_bodies
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    // 탭할 때마다 떨어지는 상자가 생성되고 부딪히는 물리 효과 추가
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
}

//#Preview {
//    ContentView()
//}
