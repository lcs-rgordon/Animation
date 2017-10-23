import Cocoa
import Foundation


/// Re-maps a number from one range to another.
///
/// - Parameters:
///   - value: the incoming value to be converted
///   - fromLower: lower bound of the value's current range
///   - fromUpper: upper bound of the value's current range
///   - toLower: lower bound of the value's target range
///   - toUpper: upper bound of the value's target range
/// - Returns: the equivalent value in the target range
public func map(value : Double,
                fromLower : Double, fromUpper : Double,
                toLower   : Double,   toUpper : Double) -> Double {
    
    // Return the mapped value
    return toLower + (toUpper - toLower) * ((value - fromLower) / (fromUpper - fromLower))
    
}

/*
 
 // Ported from Processing map function
 // TODO: Trap possible errors noted below
 
static public final float map(float value,
float start1, float stop1,
float start2, float stop2) {
    float outgoing =
        start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
    String badness = null;
    if (outgoing != outgoing) {
        badness = "NaN (not a number)";
        
    } else if (outgoing == Float.NEGATIVE_INFINITY ||
        outgoing == Float.POSITIVE_INFINITY) {
        badness = "infinity";
    }
    if (badness != null) {
        final String msg =
            String.format("map(%s, %s, %s, %s, %s) called, which returns %s",
                          nf(value), nf(start1), nf(stop1),
                          nf(start2), nf(stop2), badness);
        PGraphics.showWarning(msg);
    }
    return outgoing;
}

*/
