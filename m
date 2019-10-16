Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472BCD9214
	for <lists+linux-mmc@lfdr.de>; Wed, 16 Oct 2019 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393483AbfJPNMu (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 16 Oct 2019 09:12:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41136 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfJPNMu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2019 09:12:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id v52so35955111qtb.8
        for <linux-mmc@vger.kernel.org>; Wed, 16 Oct 2019 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JThs1XG1ijPDoWXd001r2c0QxpUa5W2X+j98FgzGb4=;
        b=UB9ELyOZDOPd221KTRZ44E6coQpNcftSoMxNazf7t7nDHFWdnlu49LfY4juaUuij+u
         uyg+XuKVTfjGgg6f4yohjI/jki6Ey5vm/kSgHuM8jhxf8/TeIfQLhCTR8hCp5SKkjOEc
         aghKyx6Go8GpAiGyEFJslvNxarC4F497LwkwyzhKWbLaZ7BdJv16xCl6s8xTFOtqdhID
         TJFzruv3A7f6Abldxi7qPSb4ZpmJ2yHh+g3JpVmUCO+vLOrQZZ3rIcfXGEVyYPEgFO+H
         f2kIyl+jZ8TgDuq7pviRq5YjYRyEK5T0FwsIZlAqJsL0s9vXcXnOHCVpJctB3HcgeqZH
         ClHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JThs1XG1ijPDoWXd001r2c0QxpUa5W2X+j98FgzGb4=;
        b=OBjcfp//dQ0qQNbOh/tM+sWeqLYjrAQxzpBIKEZPWvbRQIzI9jwPWQIbOYu6qU0VG7
         5mF13HPT926HDQFW03ExnvidE+Gc8Je/prfsCdciS7wRQYcilVTwBOHLsp/D8t0apPQk
         9NdX3i5PHmRATZN/wsUfRKzOMg47Keq5Un8dAh/F6xgsNtUPynZitRxd5PuMpu21Lua3
         FkH5qcEtXwvaUpLM2UpkPGU/qRbj+EmLx261iBkWd12nR2YuQXm3QmZtB1wl43zPQxL5
         gZCVcuW0QYd+i6wC2MR5O9eKnEYkoP/jVoRn1aufWf4CXMluFkbrnnxw2seIoerJ16m5
         ThiQ==
X-Gm-Message-State: APjAAAW689oOMc+wGvKpWQvRt6Xui4iRDynuNKKd4yDS8HN63KWRHyge
        1Fql4sBXBbSfn3l9M+yVTftuwiT++fEeWfZklTCOgw==
X-Google-Smtp-Source: APXvYqz4WACK7QZCPQXxStJci3zXaPb5Yc24BDtLg9Q18h0g3nKjgnK1rXsHGJ3td2yB7eQaUO55uFjrFVgjSv4QrKM=
X-Received: by 2002:aed:2462:: with SMTP id s31mr45553740qtc.40.1571231567878;
 Wed, 16 Oct 2019 06:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-23-arnd@arndb.de>
In-Reply-To: <20191010203043.1241612-23-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 15:12:36 +0200
Message-ID: <CACRpkdb07KyJDgACuh2ho822pHAUcw2ubu=WJwqxf8NO-Pv+_A@mail.gmail.com>
Subject: Re: [PATCH 23/36] ARM: s3c: move s3cmci pinctrl handling into board files
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 10, 2019 at 10:47 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Rather than call the internal s3c_gpio_cfgall_range() function
> through a platform header, move the code into the set_power
> callback that is already exported by the board, and add
> a default implementation.
>
> In DT mode, the code already does not set the pin config,
> so nothing changes there.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It looks good:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

It would feel better if someone was actually testing it on these
boards. I see Ben is listed as maintainer so I bet he will
pull the board out :)

Yours,
Linus Walleij
