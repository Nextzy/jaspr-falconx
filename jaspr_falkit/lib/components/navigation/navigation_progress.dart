import 'package:jaspr_falkit/lib.dart';

/// Thin progress bar fixed to the top of the page, shown while a full page
/// load triggered by a link click takes longer than [showDelay].
///
/// Renders one `<div id="fal-nav-progress" aria-hidden="true">`, its
/// `<style>`, and an inline `<script>`. The script is plain JavaScript, so it
/// works before any island loads and does not depend on Jaspr's client
/// runtime.
///
/// A click starts the timer when it is a primary-button click on a same-origin
/// `a[href]` that is not default-prevented, has no modifier key, no `download`,
/// no target other than `_self`, and does not stay on the current path and
/// query (a hash change). After [showDelay] the bar creeps toward 85% with a
/// slowing curve. `pageshow` from the back/forward cache and `pagehide` reset
/// it. A page that is still here 10 seconds after the click finishes and
/// hides the bar. With `prefers-reduced-motion: reduce` the bar does not creep.
class NavigationProgress extends StatelessComponent {
  const NavigationProgress({
    this.color = 'currentColor',
    this.height = '3px',
    this.showDelay = const Duration(milliseconds: 150),
    this.zIndex = 9999,
    this.glow = false,
    super.key,
  });

  /// CSS color of the bar and, when [glow] is true, its glow.
  final String color;

  /// CSS height of the bar.
  final String height;

  /// How long a navigation takes before the bar appears.
  final Duration showDelay;

  /// CSS `z-index` of the bar.
  final int zIndex;

  /// Whether the bar casts a soft `box-shadow` glow in [color].
  final bool glow;

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      const Component.element(
        tag: 'div',
        attributes: {'id': 'fal-nav-progress', 'aria-hidden': 'true'},
      ),
      Component.element(tag: 'style', children: [RawText(_style())]),
      Component.element(tag: 'script', children: [RawText(_script())]),
    ]);
  }

  String _style() {
    final c = _cssValue(color);
    final h = _cssValue(height);
    return '''
#fal-nav-progress{position:fixed;top:0;left:0;width:0;height:$h;background:$c;${glow ? 'box-shadow:0 0 6px $c;' : ''}opacity:0;pointer-events:none;z-index:$zIndex}
#fal-nav-progress.run{opacity:1;width:85%;transition:width 2.4s cubic-bezier(.1,.6,.2,1)}
#fal-nav-progress.done{opacity:0;width:100%;transition:width .18s ease-out,opacity .25s ease .18s}
@media (prefers-reduced-motion:reduce){#fal-nav-progress.run{transition:none}#fal-nav-progress.done{transition:opacity .25s}}''';
  }

  String _script() {
    final delay = showDelay.inMilliseconds;
    return '''
(function(){var b=document.getElementById('fal-nav-progress');if(!b)return;
var DELAY=$delay,GIVE_UP=10000,show,giveUp,hide;
function stop(){clearTimeout(show);clearTimeout(giveUp);clearTimeout(hide);}
function reset(){stop();b.className='';}
function finish(){stop();if(b.className!=='run'){b.className='';return;}b.className='done';hide=setTimeout(function(){b.className='';},450);}
function start(){stop();b.className='';show=setTimeout(function(){b.className='run';},DELAY);giveUp=setTimeout(finish,GIVE_UP);}
document.addEventListener('click',function(e){
if(e.defaultPrevented||e.button!==0||e.metaKey||e.ctrlKey||e.shiftKey||e.altKey)return;
var a=e.target&&e.target.closest?e.target.closest('a[href]'):null;if(!a)return;
if(a.hasAttribute('download'))return;
var t=a.getAttribute('target');if(t&&t!=='_self')return;
var h=a.href;if(typeof h!=='string')return;
var u;try{u=new URL(h);}catch(x){return;}
if(u.origin!==location.origin)return;
if(u.pathname===location.pathname&&u.search===location.search)return;
start();});
window.addEventListener('pageshow',function(e){if(e.persisted)reset();});
window.addEventListener('pagehide',reset);})();''';
  }

  /// Drops every character that could end the declaration, the rule, or the
  /// `<style>` element. A color or length never needs them.
  static String _cssValue(String value) =>
      value.replaceAll(RegExp(r'[<>{};\\@]'), '');
}
