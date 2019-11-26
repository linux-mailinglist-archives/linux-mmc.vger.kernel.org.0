Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A93109787
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Nov 2019 02:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfKZBW1 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 25 Nov 2019 20:22:27 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33624 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKZBW1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Nov 2019 20:22:27 -0500
Received: by mail-pg1-f182.google.com with SMTP id 6so3576164pgk.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2019 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=AtPRMYJsiWkwHiFFHZwBcUcKfK6FWEVPRzt0kULjoMk=;
        b=ZsjGN9G3y6QPq/SuMUBdQdPjWMaaqGTsg369cIOxGzFWf76C6KhXoa28fC3PDPNsv+
         7QWs10eF6lz9is8be53GzoigIeoomf7xOruNp1Y/bJBePCpSOXYLOA4H2/KJ77cRhk05
         x0KvyJoRGbdZ9bbhy/XpP674iOcUGGYfS/H2W20tUStvBWi2ytsJmsFm0cuVxx0LrVhE
         fJVgEsvqgV4FirojN5oa+BaOcKBvYRvapbjhDDbYa7cJEo8dtqNlxLA6y+V/jXxspakD
         Spg4rGfGWHPFYnszQbpNq8GQ03LpilTeTOS2V8qw2dZ1gjduJRffPZoij6u5G0iQYIDa
         y3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AtPRMYJsiWkwHiFFHZwBcUcKfK6FWEVPRzt0kULjoMk=;
        b=MIHxgGI3hRdMLB7qirkX6QJ/yv8k3GShqxLvTlMf/nwS3lH/d/9C02A6HxG9ZX0hBb
         fOYafMU1qYlOaY9wGLYp10nX8k/ZxY1zy3so3whqxdAjmCScUPbNOL2Hk/aHrOcO4CGQ
         J1MwmP9nvFdgR2WrJrtik6Zctk2YeA9Lh+0UITbzaD09yS3lWxsG3VDipq0ZlZUau+dy
         QxbX155Bxzu+vAxEdG+jtBluIVn/TIPDoOUPw1+AV9edsBbJvqVi0NdL6z8yNQ7tdMJ7
         hA8F0lCQBu9/CCDCqhPkHvYjCEnKbyoq89sMQ5+4S29Tx2AcNuPLSFzZKG3o1f2V8Vzx
         9M8A==
X-Gm-Message-State: APjAAAVrW0LrA/z6yyZdjnh3f7KC2fMtq6H8VWj7EDZUKc6qlcVtWubU
        Xb8uphRsX11nkpW8triJNeaTMQ==
X-Google-Smtp-Source: APXvYqzCduZpVjmTaqiZExnNw3OMBfwJqTBjnW12KeeSXsvhWXRVkr9xrQzORP/oWCYG2oNVoKbw8g==
X-Received: by 2002:a63:6a47:: with SMTP id f68mr35998951pgc.35.1574731346647;
        Mon, 25 Nov 2019 17:22:26 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id r15sm9985094pfh.81.2019.11.25.17.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Nov 2019 17:22:25 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Cc:     jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: Amlogic 32-bit Meson SoC SDHC MMC controller driver
In-Reply-To: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
References: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 25 Nov 2019 17:22:25 -0800
Message-ID: <7htv6rh1ny.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> this is the first non-RFC version of the driver for the Amlogic "SDHC"
> MMC controller found on Meson6, Meson8, Meson8b and Meson8m2 SoCs.

This will need to be reviewed/merged by the MMC maintainers, but to get
some broader testing (including in KernelCI) I've added this series to
the 'testing' branch of my tree so it will be included in my 'integ'
branch.

Kevin
