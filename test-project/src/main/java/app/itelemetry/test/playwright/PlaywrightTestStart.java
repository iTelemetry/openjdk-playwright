package app.itelemetry.test.playwright;

import com.microsoft.playwright.Browser;
import com.microsoft.playwright.BrowserContext;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.Playwright;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class PlaywrightTestStart {

    public static void main(String[] args) throws IOException {
        try (Playwright playwright = Playwright.create()) {
            System.out.println("Launched Playwright");
            try (Browser browser = playwright.chromium().launch()) {
                System.out.println("Launched Chromium browser");
                BrowserContext context = browser.newContext();
                System.out.println("Created browser context");

                Page page = context.newPage();
                System.out.println("Created page");

                page.navigate("https://google.com");
                System.out.println("Navigated to google");

                byte[] screenshot = page.screenshot(new Page.ScreenshotOptions());
                System.out.println("Took screenshot");

                File screenshotFolder = new File("/app/screenshot");
                if (!screenshotFolder.exists()) {
                    if (!screenshotFolder.mkdir()) {
                        throw new IOException("Unable to create directory");
                    }
                } else if (!screenshotFolder.isDirectory()) {
                    throw new IOException("Path of screenshot folder already exists and is not a directory");
                }

                try (FileOutputStream fos = new FileOutputStream(new File(screenshotFolder, "google.png"))) {
                    fos.write(screenshot);
                }

                page.close();
            }
        }
    }

}
