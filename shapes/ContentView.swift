import SwiftUI

var child = UIHostingController(rootView: ContentView())

struct ContentView: View
{
    @State var position = ""
    
    @State var colour = ""
    @State var selectedColour = Color.white
    
    @State var shape = ""
    
    @State var shapeInfoList: [ShapeInfo] = []
    
    @State var bezier: AnyShape?
    
    @State var canvasSizeX: CGFloat = 0
    @State var canvasSizeY: CGFloat = 0
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                HStack
                {
                    VStack(spacing: 10)
                    {
                        
                        Text("Position")
                            .font(.headline)
                            RadioButtonField(
                                id: "topLeft",
                                label: "Top Left",
                                color:.black,
                                bgColor: .blue,
                                isMarked: position == "topLeft" ? true : false,
                                callback: { selected in
                                    position = selected
                                }
                            )
                            RadioButtonField(
                                id: "topRight",
                                label: "Top Right",
                                color:.black,
                                bgColor: .blue,
                                isMarked: position == "topRight" ? true : false,
                                callback: { selected in
                                    position = selected
                                }
                            )
                            
                            RadioButtonField(
                                id: "bottomLeft",
                                label: "Bottom Left",
                                color:.black,
                                bgColor: .blue,
                                isMarked: position == "bottomLeft" ? true : false,
                                callback: { selected in
                                    position = selected
                                }
                            )
                            
                            RadioButtonField(
                                id: "bottomRight",
                                label: "Bottom Right",
                                color:.black,
                                bgColor: .blue,
                                isMarked: position == "bottomRight" ? true : false,
                                callback: { selected in
                                    position = selected
                                }
                            )
                    }
                    
                    
                    // Colour
                    VStack(spacing: 10)
                    {
                        Text("Colour")
                            .font(.headline)
                        
                            RadioButtonField(
                                id: "blue",
                                label: "Blue",
                                color:.black,
                                bgColor: .blue,
                                isMarked: colour == "blue" ? true : false,
                                callback: { selected in
                                    colour = selected
                                    selectedColour = .blue
                                }
                            )
                            
                            RadioButtonField(
                                id: "green",
                                label: "Green",
                                color:.black,
                                bgColor: .blue,
                                isMarked: colour == "green" ? true : false,
                                callback: { selected in
                                    colour = selected
                                    selectedColour = .green
                                }
                            )
                            
                            RadioButtonField(
                                id: "purple",
                                label: "Purple",
                                color:.black,
                                bgColor: .blue,
                                isMarked: colour == "purple" ? true : false,
                                callback: { selected in
                                    colour = selected
                                    selectedColour = .purple
                                }
                            )
                            
                            RadioButtonField(
                                id: "indigo",
                                label: "Indigo",
                                color:.black,
                                bgColor: .blue,
                                isMarked: colour == "indigo" ? true : false,
                                callback: { selected in
                                    colour = selected
                                    selectedColour = .indigo
                                }
                            )
                    }
                    
                    
                    //Shape
                    VStack(spacing: 10)
                    {
                        Text("Shape")
                            .font(.headline)
                            RadioButtonField(
                                id: "square",
                                label: "Square",
                                color:.black,
                                bgColor: .blue,
                                isMarked: shape == "square" ? true : false,
                                callback: { selected in
                                    shape = selected
                                }
                            )
                            
                            RadioButtonField(
                                id: "circle",
                                label: "Circle",
                                color:.black,
                                bgColor: .blue,
                                isMarked: shape  == "circle" ? true : false,
                                callback: { selected in
                                    shape = selected
                                }
                            )
                            
                            RadioButtonField(
                                id: "triangle",
                                label: "Triangle",
                                color:.black,
                                bgColor: .blue,
                                isMarked: shape == "triangle" ? true : false,
                                callback: { selected in
                                    shape = selected
                                }
                            )
                            
                            RadioButtonField(
                                id: "halfCircle",
                                label: "Half Circle",
                                color:.black,
                                bgColor: .blue,
                                isMarked: shape == "halfCircle" ? true : false,
                                callback: { selected in
                                    shape = selected
                                }
                            )
                    }
                }
                
                
                HStack(spacing: 25)
                {
                    
                    Button("Draw", action: {
                        
                        if(shape == "circle")
                        {
                            shapeInfoList.append(ShapeInfo(color: selectedColour, position: position, shape: AnyShape(Circle())))
                        }
                        else if(shape == "square")
                        {
                            shapeInfoList.append(ShapeInfo(color: selectedColour, position: position, shape: AnyShape(Rectangle())))
                        }
                        else if(shape == "triangle")
                        {
                            shapeInfoList.append(ShapeInfo(color: selectedColour, position: position, shape: AnyShape(Triangle())))
                        }
                        else if(shape == "halfCircle")
                        {
                                shapeInfoList.append(ShapeInfo(color: selectedColour, position: position, shape: AnyShape(HalfCircle(startAngle: Angle.degrees(0), endAngle: Angle.degrees(180), clockwise: true))))
                        }
                    })
                        .font(.system(size: 25, weight: .medium))
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100, height: 45)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                    
                    Button("Bezier", action: {
                        bezier = AnyShape(BezierCurve())
                    })
                        .font(.system(size: 25, weight: .medium))
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100, height: 45)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                ZStack
                {
                    GeometryReader{geometry in
                        ForEach(0..<shapeInfoList.count, id: \.self)
                        {
                            if(shapeInfoList[$0].position == "topLeft")
                            {
                                ShapeRow(shape: shapeInfoList[$0],positionX: geometry.size.width/10,positionY: geometry.size.height/10, sizeX: geometry.size.width/7, sizeY: geometry.size.height/7)
                            }
                            else if(shapeInfoList[$0].position == "topRight")
                            {
                                ShapeRow(shape: shapeInfoList[$0],positionX: geometry.size.width-geometry.size.width/10,positionY: geometry.size.height/10, sizeX: geometry.size.width/7, sizeY: geometry.size.height/7)
                            }
                            else if(shapeInfoList[$0].position == "bottomLeft")
                            {
                                ShapeRow(shape: shapeInfoList[$0],positionX: geometry.size.width/10,positionY: geometry.size.height-geometry.size.height/10, sizeX: geometry.size.width/7, sizeY: geometry.size.height/7)
                            }
                            else if(shapeInfoList[$0].position == "bottomRight")
                            {
                                ShapeRow(shape: shapeInfoList[$0],positionX: geometry.size.width-geometry.size.width/10,positionY: geometry.size.height-geometry.size.height/10, sizeX: geometry.size.width/7, sizeY: geometry.size.height/7)
                            }
                            
                        }
                    }
                    bezier
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}

struct RadioButtonField: View
{
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let bgColor: Color
    let textSize: CGFloat
    let isMarked:Bool
    let callback: (String)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 20,
        color: Color = Color.black,
        bgColor: Color = Color.black,
        textSize: CGFloat = 16,
        isMarked: Bool = false,
        callback: @escaping (String)->()
        ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.bgColor = bgColor
        self.textSize = textSize
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View
    {
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .clipShape(Circle())
                    .foregroundColor(self.bgColor)
                Text(label)
                    .font(Font.system(size: textSize))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

struct Triangle: Shape
{
    func path(in rect: CGRect) -> Path
    {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct BezierCurve : Shape
{
    func path(in rect: CGRect) -> Path
    {
        var p = Path()

        p.move(to: CGPoint(x: 250, y: 100))
        p.addQuadCurve(to: CGPoint(x: 250, y: 250), control: CGPoint(x: 100, y: 5))
        p.addQuadCurve(to: CGPoint(x: 100, y: 250), control: CGPoint(x: 100, y: 5))
        p.addQuadCurve(to: CGPoint(x: 25, y: 250), control: CGPoint(x: 100, y: 500))
        return p.strokedPath(.init(lineWidth: 3, dashPhase: 10))
    }
}

struct HalfCircle: Shape
{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path
    {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

struct AnyShape: Shape
{
    private let builder: (CGRect) -> Path

    init<S: Shape>(_ shape: S)
    {
        builder =
        { rect in
            let path = shape.path(in: rect)
            return path
        }
    }

    func path(in rect: CGRect) -> Path
    {
        return builder(rect)
    }
}


struct ShapeInfo : Identifiable
{
    let id = UUID()
    var color: Color
    var position: String
    var shape: AnyShape
}

struct ShapeRow: View
{
    var shape: ShapeInfo
    var positionX: CGFloat = 0
    var positionY: CGFloat = 0
    var sizeX: CGFloat = 0
    var sizeY: CGFloat = 0
    
    var body: some View
    {
        shape.shape.position(x: positionX, y: positionY).foregroundColor(shape.color).frame(width: sizeX, height: sizeY)
    }
}
