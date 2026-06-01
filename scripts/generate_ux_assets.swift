import AppKit
import Foundation

let root = URL(fileURLWithPath: #filePath)
  .deletingLastPathComponent()
  .deletingLastPathComponent()
let outDir = root.appendingPathComponent("images/ux")
try FileManager.default.createDirectory(at: outDir, withIntermediateDirectories: true)

let W: CGFloat = 900
let H: CGFloat = 1500

struct Palette {
  static let bg = NSColor(calibratedRed: 0.965, green: 0.972, blue: 0.978, alpha: 1)
  static let ink = NSColor(calibratedRed: 0.145, green: 0.188, blue: 0.231, alpha: 1)
  static let muted = NSColor(calibratedRed: 0.419, green: 0.455, blue: 0.502, alpha: 1)
  static let line = NSColor(calibratedRed: 0.621, green: 0.668, blue: 0.714, alpha: 1)
  static let soft = NSColor(calibratedRed: 0.944, green: 0.961, blue: 0.961, alpha: 1)
  static let image = NSColor(calibratedRed: 0.929, green: 0.941, blue: 0.953, alpha: 1)
  static let accent = NSColor(calibratedRed: 0.122, green: 0.435, blue: 0.357, alpha: 1)
  static let accentFill = NSColor(calibratedRed: 0.918, green: 0.965, blue: 0.941, alpha: 1)
  static let white = NSColor.white
}

func topRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> NSRect {
  NSRect(x: x, y: H - y - height, width: width, height: height)
}

func drawRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, fill: NSColor = Palette.white, stroke: NSColor = Palette.muted, strokeWidth: CGFloat = 2, radius: CGFloat = 0) {
  let path = NSBezierPath(roundedRect: topRect(x, y, width, height), xRadius: radius, yRadius: radius)
  fill.setFill()
  path.fill()
  stroke.setStroke()
  path.lineWidth = strokeWidth
  path.stroke()
}

func fillRect(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, color: NSColor, radius: CGFloat = 0) {
  let path = NSBezierPath(roundedRect: topRect(x, y, width, height), xRadius: radius, yRadius: radius)
  color.setFill()
  path.fill()
}

func drawLine(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat, color: NSColor = Palette.ink, width: CGFloat = 2) {
  let path = NSBezierPath()
  path.move(to: NSPoint(x: x1, y: H - y1))
  path.line(to: NSPoint(x: x2, y: H - y2))
  path.lineWidth = width
  path.lineCapStyle = .round
  color.setStroke()
  path.stroke()
}

func font(_ size: CGFloat, _ weight: NSFont.Weight = .regular) -> NSFont {
  NSFont.systemFont(ofSize: size, weight: weight)
}

func drawText(_ value: String, _ x: CGFloat, _ y: CGFloat, size: CGFloat = 22, weight: NSFont.Weight = .regular, color: NSColor = Palette.ink, width: CGFloat? = nil, align: NSTextAlignment = .left) {
  let paragraph = NSMutableParagraphStyle()
  paragraph.alignment = align
  let attrs: [NSAttributedString.Key: Any] = [
    .font: font(size, weight),
    .foregroundColor: color,
    .paragraphStyle: paragraph
  ]
  let textHeight = size * 1.35
  let rect = topRect(x, y - size, width ?? 500, textHeight + 4)
  NSString(string: value).draw(in: rect, withAttributes: attrs)
}

func drawLines(_ x: CGFloat, _ y: CGFloat, _ widths: [CGFloat], gap: CGFloat = 28, height: CGFloat = 9) {
  for (index, width) in widths.enumerated() {
    fillRect(x, y + CGFloat(index) * gap, width, height, color: Palette.line, radius: height / 2)
  }
}

func drawButton(_ label: String, _ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, filled: Bool = false) {
  drawRect(x, y, width, height, fill: filled ? Palette.accentFill : Palette.white, stroke: filled ? Palette.accent : Palette.line, strokeWidth: 2.5, radius: 7)
  drawText(label, x, y + height / 2 + 7, size: 18, weight: .semibold, width: width, align: .center)
}

func base(_ title: String) {
  fillRect(0, 0, W, H, color: Palette.bg)
  drawRect(192, 32, 516, 1436, fill: Palette.white, stroke: Palette.ink, strokeWidth: 5, radius: 14)
  drawRect(224, 106, 452, 1288, fill: Palette.white, stroke: Palette.line, strokeWidth: 2)
  fillRect(392, 66, 116, 14, color: Palette.line, radius: 7)
  drawRect(224, 106, 452, 94, fill: Palette.soft, stroke: Palette.line, strokeWidth: 2)
  drawLine(252, 146, 284, 146, width: 2.5)
  drawLine(252, 158, 284, 158, width: 2.5)
  drawLine(252, 170, 284, 170, width: 2.5)
  drawText("Campus Plate", 322, 163, size: 25, weight: .bold, width: 220)
  drawRect(621, 141, 30, 30, fill: Palette.white, stroke: Palette.muted, strokeWidth: 2.5, radius: 5)
  drawText(title, 250, 260, size: 54, weight: .bold, width: 390)
  drawRect(224, 1315, 452, 79, fill: Palette.soft, stroke: Palette.line, strokeWidth: 2)
  for (index, label) in ["Home", "Search", "Cart", "Me"].enumerated() {
    let centerX = 285 + CGFloat(index) * 108
    drawRect(centerX - 14, 1340, 28, 28, fill: Palette.white, stroke: Palette.line, strokeWidth: 2, radius: 5)
    drawText(label, centerX - 45, 1385, size: 16, weight: .semibold, color: Palette.muted, width: 90, align: .center)
  }
}

func card(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat, titleWidth: CGFloat = 180, withImage: Bool = true) {
  drawRect(x, y, width, height, fill: Palette.white, stroke: Palette.muted, strokeWidth: 2.5, radius: 5)
  let lineX: CGFloat
  if withImage {
    drawRect(x + 22, y + 22, 110, 104, fill: Palette.image, stroke: Palette.line, strokeWidth: 2, radius: 4)
    lineX = x + 156
  } else {
    lineX = x + 24
  }
  drawLines(lineX, y + 34, [titleWidth, titleWidth + 44, max(90, titleWidth - 14)], gap: 26, height: 9)
  drawButton("View", lineX, y + height - 45, 96, 34, filled: true)
}

func save(_ name: String, draw: () -> Void) {
  let image = NSImage(size: NSSize(width: W, height: H))
  image.lockFocus()
  draw()
  image.unlockFocus()

  guard
    let tiff = image.tiffRepresentation,
    let bitmap = NSBitmapImageRep(data: tiff),
    let png = bitmap.representation(using: .png, properties: [:])
  else {
    fatalError("Could not create PNG data for \(name)")
  }

  let out = outDir.appendingPathComponent("\(name).png")
  try! png.write(to: out)
}

func discover() {
  base("Discover")
  drawRect(250, 298, 400, 58, fill: Palette.white, stroke: Palette.line, strokeWidth: 2, radius: 6)
  drawText("Search meals near NYU", 278, 335, size: 23, width: 330)
  drawButton("Near", 250, 386, 112, 48, filled: true)
  drawButton("Open now", 384, 386, 112, 48, filled: true)
  drawButton("Fast", 520, 386, 112, 48, filled: true)
  drawRect(250, 470, 400, 62, fill: Palette.soft, stroke: Palette.muted, strokeWidth: 2, radius: 5)
  drawText("Recommended today", 272, 510, size: 27, weight: .bold, width: 330)
  card(250, 558, 400, 154, titleWidth: 178)
  card(250, 764, 400, 154, titleWidth: 150)
  card(250, 970, 400, 154, titleWidth: 188)
}

func results() {
  base("Results")
  drawRect(250, 298, 400, 58, fill: Palette.white, stroke: Palette.line, strokeWidth: 2, radius: 6)
  drawText("Bowls near Washington Sq.", 276, 335, size: 22, width: 340)
  drawButton("Filter", 250, 388, 122, 48, filled: true)
  drawRect(394, 388, 256, 48, fill: Palette.white, stroke: Palette.line, strokeWidth: 2, radius: 6)
  drawText("Sort by walk time", 420, 420, size: 18, color: Palette.muted, width: 210)
  for (index, y) in [480, 656, 832, 1008].enumerated() {
    card(250, CGFloat(y), 400, 132, titleWidth: 178 - CGFloat(index * 8))
  }
}

func menu() {
  base("Menu")
  drawRect(250, 292, 400, 214, fill: Palette.image, stroke: Palette.line, strokeWidth: 2, radius: 4)
  drawText("Restaurant photo", 250, 412, size: 19, color: Palette.muted, width: 400, align: .center)
  drawLines(250, 545, [250, 175], gap: 32, height: 11)
  drawText("8 min walk  /  Pickup", 250, 624, size: 22, color: Palette.muted, width: 360)
  drawRect(250, 666, 400, 54, fill: Palette.soft, stroke: Palette.line, strokeWidth: 2, radius: 5)
  for (label, x) in [("Bowls", 250), ("Sides", 384), ("Drinks", 518)] {
    drawText(label, CGFloat(x), 700, size: 18, weight: .semibold, color: Palette.muted, width: 120, align: .center)
  }
  for (name, y) in [("Chicken rice bowl", 760), ("Tofu curry bowl", 908), ("Iced tea", 1056)] {
    drawRect(250, CGFloat(y), 400, 110, fill: Palette.white, stroke: Palette.muted, strokeWidth: 2.5, radius: 5)
    drawText(name, 276, CGFloat(y) + 40, size: 22, width: 250)
    drawLines(276, CGFloat(y) + 72, [238], height: 8)
    drawButton("+", 582, CGFloat(y) + 34, 44, 42, filled: true)
  }
  drawButton("View cart", 250, 1210, 400, 70, filled: true)
}

func filters() {
  base("Filters")
  drawRect(250, 300, 400, 96, fill: Palette.soft, stroke: Palette.line, strokeWidth: 2, radius: 5)
  drawText("Narrow the list", 278, 359, size: 28, weight: .bold, width: 330)
  let rows: [(CGFloat, String, [String])] = [
    (452, "Diet", ["Vegetarian", "Vegan", "Halal"]),
    (606, "Price", ["$", "$$", "$$$"]),
    (760, "Distance", ["5 min", "10 min", "15 min"]),
    (914, "Pickup time", ["Now", "Soon", "Later"])
  ]
  for (y, heading, choices) in rows {
    drawText(heading, 250, y, size: 27, weight: .bold, width: 300)
    for (index, choice) in choices.enumerated() {
      drawButton(choice, 250 + CGFloat(index) * 136, y + 24, 118, 44)
    }
  }
  drawButton("Apply filters", 250, 1130, 400, 70, filled: true)
  drawButton("Clear", 250, 1220, 400, 54)
}

func cart() {
  base("Cart")
  for (name, y) in [("Chicken rice bowl", 320), ("Miso soup", 492), ("Iced tea", 664)] {
    drawRect(250, CGFloat(y), 400, 126, fill: Palette.white, stroke: Palette.muted, strokeWidth: 2.5, radius: 5)
    drawText(name, 276, CGFloat(y) + 42, size: 22, width: 240)
    drawLines(276, CGFloat(y) + 74, [204], height: 8)
    drawRect(512, CGFloat(y) + 38, 112, 44, fill: Palette.white, stroke: Palette.line, strokeWidth: 2, radius: 6)
    drawText("-   1   +", 512, CGFloat(y) + 68, size: 18, weight: .semibold, width: 112, align: .center)
  }
  drawRect(250, 856, 400, 222, fill: Palette.soft, stroke: Palette.line, strokeWidth: 2, radius: 5)
  drawText("Order summary", 276, 902, size: 27, weight: .bold, width: 320)
  drawLines(276, 940, [328, 290, 328, 220], gap: 32, height: 9)
  drawButton("Checkout", 250, 1190, 400, 70, filled: true)
}

func checkout() {
  base("Checkout")
  for (heading, y) in [("Pickup details", 320), ("Payment", 520), ("Summary", 720)] {
    drawRect(250, CGFloat(y), 400, 148, fill: Palette.white, stroke: Palette.muted, strokeWidth: 2.5, radius: 5)
    drawText(heading, 276, CGFloat(y) + 42, size: 27, weight: .bold, width: 320)
    drawLines(276, CGFloat(y) + 82, [306, 238], gap: 28, height: 9)
  }
  drawRect(250, 942, 400, 140, fill: Palette.soft, stroke: Palette.line, strokeWidth: 2, radius: 5)
  drawText("Total", 276, 993, size: 27, weight: .bold, width: 320)
  drawLines(276, 1026, [330, 280], gap: 30, height: 9)
  drawButton("Place order", 250, 1190, 400, 70, filled: true)
}

func status() {
  base("Status")
  drawRect(250, 310, 400, 172, fill: Palette.accentFill, stroke: Palette.accent, strokeWidth: 2.5, radius: 5)
  drawText("Ready in 12 min", 250, 395, size: 28, weight: .bold, width: 400, align: .center)
  drawLine(310, 596, 590, 596, color: Palette.line, width: 4)
  for (x, label) in [(310, "Sent"), (450, "Prep"), (590, "Ready")] {
    drawRect(CGFloat(x) - 31, 565, 62, 62, fill: Palette.white, stroke: Palette.accent, strokeWidth: 2.5, radius: 31)
    drawText(label, CGFloat(x) - 55, 665, size: 18, weight: .semibold, color: Palette.muted, width: 110, align: .center)
  }
  drawRect(250, 744, 400, 258, fill: Palette.image, stroke: Palette.line, strokeWidth: 2, radius: 5)
  drawText("Map preview", 250, 875, size: 23, color: Palette.muted, width: 400, align: .center)
  drawButton("Get directions", 250, 1068, 400, 62)
  drawButton("Order again", 250, 1160, 400, 62)
}

save("wireframe-01-discover", draw: discover)
save("wireframe-02-results", draw: results)
save("wireframe-03-menu", draw: menu)
save("wireframe-04-filters", draw: filters)
save("wireframe-05-cart", draw: cart)
save("wireframe-06-checkout", draw: checkout)
save("wireframe-07-status", draw: status)
