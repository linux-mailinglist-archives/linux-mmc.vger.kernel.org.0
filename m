Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5674B4FC2
	for <lists+linux-mmc@lfdr.de>; Tue, 17 Sep 2019 15:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfIQN5G (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 17 Sep 2019 09:57:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35425 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfIQN5F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2019 09:57:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id m7so2958487lji.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2019 06:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gue+6p3sEZoY9T4790P0La+6r3js3LuUa0GxehQHvN8=;
        b=K4oBcW3XJ8eh2hWnZqM01fgXhtYw5HB7srZSFPYaAt81xOhZyB5M8M6KULfP7grhAz
         0x0Cv1elFSEHw9rurUfXrDr172hNCTKjXzD2Q/F9/vbHibpbzz34+dZlLeVXH0l8o1Db
         lLX0c+t+jiMcpc7ocEs6F29KpvaSQo+L2BzrdTyKy4zGFeUSaryOR9miccVvBhBrevrt
         lnrUL/nAOWrzHnH+J/U59vRQQiG29WAvlF5iaCmHLSwe/ViY59aFG1hx704MXpOlHOAh
         mK9QKMM49yeaMQZ6gmjCzDZcG+Xn/f/8/QCPliSjmCoPiO3s7PXofyGhsUWFcMHMo/WG
         KG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gue+6p3sEZoY9T4790P0La+6r3js3LuUa0GxehQHvN8=;
        b=kC0FAfq+jW8SS3xeNAcrKB0mKEq4k8hAxI/DQEbWwX7axxrqO9kKbJCqPs7F88q00+
         2oj1ixc61wJOHd+ys+btPksUZKOFBYwYmJGKOU/LVcNJ/liITLxNLXgJXfQlTBWmsP/m
         K7Yky9IIKIZnw7hCtZ1RflbZlzO8JsuMHpNj7VOYrQJ0zKkA/9EtXnXGCW7i2CK4o2PN
         tCGLAyl/dc9isjPY0pLUFWlBsp6vsYR+nfsZ3/thqTDh6GbURgcV6dd/g/67PaRV/QBo
         ssu3qhJQufCy9XjikIka08FwEiz7gFq1E9DmtT1VRf32/mmqRQ1tzGWJ+Lh+0yaBjDP6
         SxOg==
X-Gm-Message-State: APjAAAUx1sY8PogJfIgeP/P/khpJRAXpunN93Lgn+jG77pd03lirEyzT
        6BK09dJ5lOaDDrXphbM/KH2gsQfDinyrE/fNgOQ=
X-Google-Smtp-Source: APXvYqx7ImWwKBizDyTe6Jw6lirQfItvDYF043T0LZLuwqHMm/kGWc/Gij6ABlPRAtmX5sxrO2Zc9jfvVIBHxXDSDr8=
X-Received: by 2002:a2e:141c:: with SMTP id u28mr2055407ljd.44.1568728624136;
 Tue, 17 Sep 2019 06:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <b19a0640-5d71-a005-eb0f-c6840f181e5d@free.fr> <20190917081931.GI25745@shell.armlinux.org.uk>
 <20190917104200.GJ25745@shell.armlinux.org.uk> <20190917111631.GL25745@shell.armlinux.org.uk>
 <20190917114210.GM25745@shell.armlinux.org.uk> <20190917123326.GN25745@shell.armlinux.org.uk>
 <20190917130759.GO25745@shell.armlinux.org.uk> <CAOMZO5DXv8g5qTGdvobDdLWim+tW=vK4+K=P-VqJK23KERMhJw@mail.gmail.com>
 <20190917133317.GQ25745@shell.armlinux.org.uk> <CAOMZO5DS_1Uc9TMc29e+8tCg-srvMjf3uth_9P3cnro6det+7A@mail.gmail.com>
 <20190917135157.GT25745@shell.armlinux.org.uk>
In-Reply-To: <20190917135157.GT25745@shell.armlinux.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Sep 2019 10:56:59 -0300
Message-ID: <CAOMZO5BDirX0Fwo716v1ddYaaO+OL8Woht63mw8OEhDuMBTb8Q@mail.gmail.com>
Subject: Re: [REGRESSION] sdhci no longer detects SD cards on LX2160A
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Li Yang <leoyang.li@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        dann frazier <dann.frazier@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[Adding Li Yang]

On Tue, Sep 17, 2019 at 10:52 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> The pressing question seems to be this:
>
> Are the eSDHC on the LX2160A DMA coherent or are they not?
>
> Any chances of finding out internally what the true answer to that,
> rather than me poking about trying stuff experimentally?  Having a
> definitive answer for a potentially data-corrupting change would
> be really good...

Li Yang,

Could you please help to confirm Russell's question?
