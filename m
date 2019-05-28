Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6662D2C1CF
	for <lists+linux-mmc@lfdr.de>; Tue, 28 May 2019 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfE1Ixs (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 28 May 2019 04:53:48 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36521 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE1Ixr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2019 04:53:47 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so12294453vsp.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 May 2019 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvPyYljb7JCOrJ33Ko5bumzGJo9yaiTXxiuXC/YYxTg=;
        b=jX13nGRPAPQI1hudE0X4kQErmhGYYfoL3HEp017zRgTTQqSLqgi4ZQek3ZoSFMxBdU
         /yRFxKtEShA+2g/SGMrieED29wDcQdd5BGbasxRNkqmWV2wIz0TZjWrcjM7Heh2wMW+W
         c3MKVnGHejU3lxN+pyIMTgv8eooombwckW0jjXenNUvhhB+yjrB+lCC6pS8zZWZk72JR
         Pw77jREudMFS/UiJoYxJWClw3K5NX+ITUS4mvilMNIbIlySv9oEL1B2rkoUjaYJdxRS2
         sfpXJ9cOPN61iuyASFipfhH5HVnpqd87PoQrboLqB8p++c//5p0Vzt3LgQsXLF6Sxpv8
         2YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvPyYljb7JCOrJ33Ko5bumzGJo9yaiTXxiuXC/YYxTg=;
        b=cVc8fr1Fz3FvuY8nNNSB/JWm+bN7dGsvR6eDwNZzPS6vt/x9b+4UFBAfFNXWh4LoF8
         KbH/d9CPDUpt6CpYfMOu58ZothJ5YG/8eWfZlReujpi+RytDWCWDP8JqVcNMQ838pL3W
         ZeXdzuxEJX0MVg/iqbgDa0i4eMB/s9oRzXShSJqOhNhrDkVKidnfZKEqLDc+hSjACMzx
         qehQ/wBCZykWqsYuZwodiV/G0KNC/fyDDnLNkgNPxdzXgDpddzSe0vMIHDi1LT2GpWkD
         2GN+pbiQOcc9aMTXYDCdkJk87f4cRmnPUsjjwqYeKbSV4fwkcwqhl+1TlqPCcBtWx2kK
         ZV8g==
X-Gm-Message-State: APjAAAWspb7+HmQxmin3Ox54cMZgXeMQu+Ry1exXYjiXOFkQUqFJZFse
        QKsfEf5Xp/76WR1cS/xAyNQEQxVcBvcpmPvo52xOmQ==
X-Google-Smtp-Source: APXvYqxxu7B75fGza2d3hxaqgN1ayByiKBL1TJG814+ezkFuh/mzNJ5XOp9JlYbecqc4TcFNqA/1BrHCMWkm2vwSEVk=
X-Received: by 2002:a67:7c58:: with SMTP id x85mr37940337vsc.191.1559033626532;
 Tue, 28 May 2019 01:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190527124307.32075-1-narmstrong@baylibre.com> <20190527124307.32075-2-narmstrong@baylibre.com>
In-Reply-To: <20190527124307.32075-2-narmstrong@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:53:10 +0200
Message-ID: <CAPDyKFrDKkDO383buUzkWw_4wX15pNvexbHSvJAxHc-na4PSKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: meson-gx: add dram-access-quirk property
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 May 2019 at 14:43, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic G12A SoC family, (only) the SDIO controller has a bug which
> makes any DRAM access from the MMC controller fail.
>
> Add the amlogic,dram-access-quirk property so signal this particular
> controller has this bug and needs a quirk to work properly.
>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> index 13e70409e8ac..ccc5358db131 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx.txt
> @@ -22,6 +22,10 @@ Required properties:
>    clock rate requested by the MMC core.
>  - resets     : phandle of the internal reset line
>
> +Optional properties:
> +- amlogic,dram-access-quirk: set when controller's internal DMA engine cannot access the
> +  DRAM memory, like on the G12A dedicated SDIO controller.
> +
>  Example:
>
>         sd_emmc_a: mmc@70000 {
> --
> 2.21.0
>
