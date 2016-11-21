// MARK: Utils
class ReferencesArray<Element> {}

// MARK: Primitives
protocol GpuPrivitive {
    associatedtype CpuType
}

struct Vec3: GpuPrivitive {
    typealias CpuType = (Float, Float, Float)
}

struct Mat3: GpuPrivitive {
    typealias CpuType = (Vec3, Vec3, Vec3)
}

// MARK: Element
protocol Element {
    func transformation() -> Transformation
}

protocol Transformation {
    func position() -> Vec3
    func rotation() -> Rotation
}

protocol Rotation {
    func rotationMatrix() -> Mat3
}

// MARK: Scene
class Scene {
    let entities = ReferencesArray<SceneEntity>()
}

protocol SceneEntity {
    var identity: String {get set}
}

// MARK: Drawable
protocol Drawable {
    var mesh: Mesh {get}
}

protocol Mesh {
    var attributes: Set<Attribute> {get}
}

// MARK: Gpu
protocol GpuName {
    var cpuIdentifier: Int {get}
}

protocol GpuCounterpart {
    static var GpuName: String {get}
    var gpuName: GpuName {get}
}

protocol PipelineVariable {
    var nameInPipeline: String {get}
}

extension PipelineVariable where Self: GpuCounterpart {
    private func identifier() -> String {
        return "\(Self.GpuName):\(nameInPipeline):\(gpuName.cpuIdentifier)"
    }
    
    var hashValue: Int {
        return identifier().hashValue
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

enum Attribute {
    case Position
    case Texel
    case Normal
}

struct Uniform: PipelineVariable, GpuCounterpart, Hashable {
    static let GpuName = "uniform"
    let gpuName: GpuName
    
    let nameInPipeline: String
}

struct Program: GpuCounterpart {
    static let GpuName = "program"
    let gpuName: GpuName
    
    let attributes: Set<Attribute>
    let uniforms: Set<Uniform>
}

// MARK: Buffers
struct VertexArray: GpuCounterpart {
    static let GpuName = "vao"
    let gpuName: GpuName
    
    let vertexBuffers: [VertexBuffer]
}

struct VertexBuffer: GpuCounterpart {
    static let GpuName = "vbo"
    let gpuName: GpuName
}

struct FrameBuffer: GpuCounterpart {
    static let GpuName = "fbo"
    let gpuName: GpuName
}

struct Texture: GpuCounterpart {
    static let GpuName = "texture"
    let gpuName: GpuName
}

// MARK: Pipeline
struct Pipeline {
    let attributes: Set<Attribute>
    let uniforms: Set<Uniform>
}

struct RenderingEntity {
    let drawable: Drawable
    let enviroment: Enviroment
}

protocol Enviroment {
    func gpuMediums() -> [GpuMedium]
}

protocol Renderer {
    func render(pipeline: Pipeline, entity: RenderingEntity)
}

// MARK: RenderPass
class GpuMedium {
    init<PrimitiveType: GpuPrivitive>(cpuValueGetter: () -> (PrimitiveType.CpuType), uniform: Uniform) {
        
    }
    
//    static func medium<T: GpuPrivitive>(cpuValueGetter: () -> (T.CpuType)) -> Self {
//        
//    }
//    func pass() {
//        
//    }
}

//class GpuMedium {
//    let primitiveGetter: () -> GpuPrivitive
//    let uniform: Uniform
//    
//    init(primitiveGetter: @escaping () -> GpuPrivitive, uniform: Uniform) {
//        self.primitiveGetter = primitiveGetter
//        self.uniform = uniform
//    }
//    
//    func passToGpu() {
//        
//    }
//}

// MARK: Playground

struct GlName: GpuName {
    let cpuIdentifier: Int
}

struct SimpleMesh: Mesh {
    let attributes: Set<Attribute>
}

struct SimpleDrawable: Drawable {
    let mesh: Mesh
}

struct SimpleRenderer: Renderer {
    func render(pipeline: Pipeline, entity: RenderingEntity) {}
}

struct SimpleEnviroment: Enviroment {
    let gpuMediumsStore: [GpuMedium]
    
    func gpuMediums() -> [GpuMedium] {
        return gpuMediumsStore
    }
}

let mvp = Uniform(gpuName: GlName(cpuIdentifier: 1), nameInPipeline: "mvp")
let colorMap = Uniform(gpuName: GlName(cpuIdentifier: 2), nameInPipeline: "colorMap")
let pipeline = Pipeline(attributes: [.Position, .Texel], uniforms: [mvp, colorMap])
let drawable = SimpleDrawable(mesh: SimpleMesh(attributes: [.Position, .Texel]))
//GpuMedium(primitiveGetter: <#T##() -> GpuPrivitive#>, uniform: <#T##Uniform#>)
//let enviroment = SimpleEnviroment(gpuMediumsStore: <#T##[GpuMedium]#>)
//renderingEntity = RenderingEntity(drawable: drawable, enviroment: <#T##Enviroment#>)
//SimpleRenderer().render(pipeline: pipeline, entity: <#T##RenderingEntity#>)
