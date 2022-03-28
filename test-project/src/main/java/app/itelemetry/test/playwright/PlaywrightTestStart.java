package app.itelemetry.test.playwright;

import com.microsoft.playwright.Browser;
import com.microsoft.playwright.BrowserContext;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.Playwright;

import java.net.URI;
import java.net.URISyntaxException;
import java.nio.file.Path;

public class PlaywrightTestStart {

    public static void main(String[] args) throws URISyntaxException {
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

                Path path = Path.of(new URI("test-protect/target/image"));
                page.screenshot(new Page.ScreenshotOptions().setPath(path));
                System.out.println("Took screenshot");

                page.close();
            }
        }
    }

}
