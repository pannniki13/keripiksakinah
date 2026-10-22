const { app, BrowserWindow, shell } = require('electron');
const path = require('node:path');

const isDev = !app.isPackaged;
let mainWindow;

function createWindow() {
  mainWindow = new BrowserWindow({
    title: 'Keripik Sakinah',
    width: 1360,
    height: 900,
    minWidth: 960,
    minHeight: 640,
    backgroundColor: '#FBF8F1',
    autoHideMenuBar: true,
    show: false,
    icon: path.join(__dirname, 'icon.ico'),
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      sandbox: true,
      webSecurity: true,
      allowRunningInsecureContent: false,
      spellcheck: false,
      devTools: isDev
    }
  });

  const appHtml = path.join(__dirname, '..', 'app', 'src', 'main', 'assets', 'index.html');
  mainWindow.loadFile(appHtml, { query: { mode: 'desktop' } });
  mainWindow.once('ready-to-show', () => mainWindow.show());

  // Keep the app local. Links to web pages open in the user's default browser.
  mainWindow.webContents.setWindowOpenHandler(({ url }) => {
    if (url.startsWith('https://') || url.startsWith('http://')) shell.openExternal(url);
    return { action: 'deny' };
  });
  mainWindow.webContents.on('will-navigate', (event, url) => {
    if (!url.startsWith('file://')) {
      event.preventDefault();
      if (url.startsWith('https://') || url.startsWith('http://')) shell.openExternal(url);
    }
  });

  mainWindow.on('closed', () => { mainWindow = null; });
}

app.whenReady().then(() => {
  app.setAppUserModelId('com.keripiksakinah.desktop');
  createWindow();
  app.on('activate', () => { if (BrowserWindow.getAllWindows().length === 0) createWindow(); });
});

app.on('window-all-closed', () => { if (process.platform !== 'darwin') app.quit(); });
