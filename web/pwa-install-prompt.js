// PWA Install Prompt Handler
// This script handles the PWA installation prompt

(function() {
  'use strict';

  let deferredPrompt;
  let installButton;

  // Check if running as PWA
  function isRunningAsPWA() {
    return (
      window.matchMedia('(display-mode: standalone)').matches ||
      window.navigator.standalone === true ||
      document.referrer.includes('android-app://')
    );
  }

  // Create install button
  function createInstallButton() {
    const button = document.createElement('button');
    button.id = 'pwa-install-button';
    button.innerHTML = `
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
        <polyline points="7 10 12 15 17 10"/>
        <line x1="12" y1="15" x2="12" y2="3"/>
      </svg>
      <span>Установить приложение</span>
    `;
    button.style.cssText = `
      position: fixed;
      bottom: 20px;
      right: 20px;
      background: #fff;
      color: #0a0a0a;
      border: none;
      padding: 12px 24px;
      border-radius: 24px;
      font-size: 14px;
      font-weight: 600;
      cursor: pointer;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      display: flex;
      align-items: center;
      gap: 8px;
      z-index: 10000;
      transition: transform 0.2s, box-shadow 0.2s;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    `;
    
    button.addEventListener('mouseenter', function() {
      button.style.transform = 'translateY(-2px)';
      button.style.boxShadow = '0 6px 16px rgba(0, 0, 0, 0.2)';
    });
    
    button.addEventListener('mouseleave', function() {
      button.style.transform = 'translateY(0)';
      button.style.boxShadow = '0 4px 12px rgba(0, 0, 0, 0.15)';
    });
    
    return button;
  }

  // Show install button
  function showInstallButton() {
    if (installButton) return;
    
    installButton = createInstallButton();
    document.body.appendChild(installButton);
    
    installButton.addEventListener('click', async function() {
      if (!deferredPrompt) return;
      
      // Show the install prompt
      deferredPrompt.prompt();
      
      // Wait for user choice
      const { outcome } = await deferredPrompt.userChoice;
      
      console.log(`User response to install prompt: ${outcome}`);
      
      // Clear the deferred prompt
      deferredPrompt = null;
      
      // Hide the button
      hideInstallButton();
    });
  }

  // Hide install button
  function hideInstallButton() {
    if (installButton) {
      installButton.style.animation = 'slideOut 0.3s ease-out';
      setTimeout(function() {
        if (installButton && installButton.parentNode) {
          installButton.parentNode.removeChild(installButton);
          installButton = null;
        }
      }, 300);
    }
  }

  // Add animation styles
  const style = document.createElement('style');
  style.textContent = `
    @keyframes slideOut {
      to {
        transform: translateX(200px);
        opacity: 0;
      }
    }
    
    @media (prefers-color-scheme: dark) {
      #pwa-install-button {
        background: #fff !important;
        color: #0a0a0a !important;
      }
    }
    
    @media (max-width: 768px) {
      #pwa-install-button {
        bottom: 80px !important;
        right: 16px !important;
        left: 16px !important;
        justify-content: center !important;
      }
    }
  `;
  document.head.appendChild(style);

  // Listen for beforeinstallprompt event
  window.addEventListener('beforeinstallprompt', function(e) {
    // Prevent default browser install prompt
    e.preventDefault();
    
    // Store the event for later use
    deferredPrompt = e;
    
    // Show custom install button if not already running as PWA
    if (!isRunningAsPWA()) {
      showInstallButton();
    }
  });

  // Listen for successful installation
  window.addEventListener('appinstalled', function() {
    console.log('PWA installed successfully');
    
    // Hide install button
    hideInstallButton();
    
    // Clear deferred prompt
    deferredPrompt = null;
    
    // Optional: Track installation
    if (window.gtag) {
      gtag('event', 'pwa_installed');
    }
  });

  // iOS Safari detection and instructions
  function isIOSSafari() {
    const ua = window.navigator.userAgent;
    const iOS = !!ua.match(/iPad/i) || !!ua.match(/iPhone/i);
    const webkit = !!ua.match(/WebKit/i);
    const iOSSafari = iOS && webkit && !ua.match(/CriOS/i);
    return iOSSafari && !isRunningAsPWA();
  }

  // Show iOS install instructions
  function showIOSInstructions() {
    const banner = document.createElement('div');
    banner.id = 'ios-install-banner';
    banner.innerHTML = `
      <div style="flex: 1;">
        <strong>Установите приложение</strong>
        <p style="margin: 4px 0 0; font-size: 13px; opacity: 0.8;">
          Нажмите <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="vertical-align: middle; margin: 0 2px;">
            <path d="M4 12h16M12 4v16"/>
          </svg> и выберите "На экран домой"
        </p>
      </div>
      <button onclick="this.parentElement.remove()" style="background: none; border: none; color: #fff; font-size: 24px; cursor: pointer; padding: 0 8px;">×</button>
    `;
    banner.style.cssText = `
      position: fixed;
      bottom: 0;
      left: 0;
      right: 0;
      background: #007aff;
      color: #fff;
      padding: 16px;
      display: flex;
      align-items: center;
      gap: 12px;
      z-index: 10000;
      box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      animation: slideUp 0.3s ease-out;
    `;
    
    const closeStyle = document.createElement('style');
    closeStyle.textContent = `
      @keyframes slideUp {
        from {
          transform: translateY(100%);
        }
        to {
          transform: translateY(0);
        }
      }
    `;
    document.head.appendChild(closeStyle);
    
    document.body.appendChild(banner);
    
    // Auto-hide after 10 seconds
    setTimeout(function() {
      if (banner.parentNode) {
        banner.remove();
      }
    }, 10000);
  }

  // Initialize
  window.addEventListener('load', function() {
    // Don't show anything if already running as PWA
    if (isRunningAsPWA()) {
      console.log('Running as PWA');
      return;
    }
    
    // Show iOS instructions if on iOS Safari
    if (isIOSSafari()) {
      setTimeout(showIOSInstructions, 2000);
    }
  });

  // Track PWA mode
  if (isRunningAsPWA()) {
    console.log('App is running in PWA mode');
    
    // Optional: Track PWA usage
    if (window.gtag) {
      gtag('event', 'pwa_mode', {
        event_category: 'engagement',
        event_label: 'running_as_pwa'
      });
    }
  }

  // Handle online/offline status
  window.addEventListener('online', function() {
    console.log('App is online');
  });

  window.addEventListener('offline', function() {
    console.log('App is offline');
  });

})();

