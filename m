Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645AA63D50
	for <lists+linux-mmc@lfdr.de>; Tue,  9 Jul 2019 23:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfGIV2L (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 9 Jul 2019 17:28:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33516 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbfGIV2L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2019 17:28:11 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so215791iog.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 14:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6xuVNtto2i+j8dGWYiMsCcIcli6lEjhIoEXTrMKI510=;
        b=mgn5jqhDsssTjORHlWne5iOQcte/3D+9lSVnvL+aVRe0U9NlV7bIUQUU6Pqu2JLA8w
         kxKV1S1UCRJJEHb0svwxcZ99UTqlU+ZZSfPZcKECQjHPjPF8AeA/u5XY/s2p17w3uGQ7
         /YMSMTKaUrSK+Oeb68cun7y5z4QBBxqHrwSck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6xuVNtto2i+j8dGWYiMsCcIcli6lEjhIoEXTrMKI510=;
        b=Wmd5GarVH3mt9SLIVsgcXI7Yx0LPM6CUJBnttOiFZLJQtzRQwicI+ccJAvJKbxAsxH
         BO0tqvA/Z2peRxHivFkTK7rgaDAp2r8ct3ckrsFJQN19Vt0a9LXVQt16sbPmZIpbbzSX
         0QmkRwFD3rJTzReV9Kb6XGkLYHZM0P6AAj/CdEF6JAPn8C57xAX/EcuQtaO+KkZ8D/tz
         KrXn4DrcxjFlETAFvEGMiqoV1y4HYiOpUCuMtr4wiPYttyZp4ukj1oxB5Gim8KM2F8I2
         h7+F58GWFJaPpVmsMAjydodD5mG8n6qyfvVa5FGV+uQ+YsP8Pj/vtxOLxO55JWWP7tzg
         5Kjg==
X-Gm-Message-State: APjAAAX8ou0pg2jqH0+qKzqU38CQfbDOMLjVcWhbJczoXlAGm/D2tSqb
        /7sLw86dpvYmUNDVdJDm4m+hgdoTQ/o=
X-Google-Smtp-Source: APXvYqwi93eQjHnq4Xm9pzxLvHXhf4Z87JECpsnpW4A/P5jBCQGymm2+yXqSZgXfgiI7wiFuXtwfrQ==
X-Received: by 2002:a5d:940b:: with SMTP id v11mr11895493ion.69.1562707690408;
        Tue, 09 Jul 2019 14:28:10 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id z26sm23923299ioi.85.2019.07.09.14.28.09
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:28:09 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id k20so99935ios.10
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jul 2019 14:28:09 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr26902780iol.269.1562707689155;
 Tue, 09 Jul 2019 14:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153448.27145-1-ulf.hansson@linaro.org> <20190618153448.27145-4-ulf.hansson@linaro.org>
In-Reply-To: <20190618153448.27145-4-ulf.hansson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 9 Jul 2019 14:27:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-guTEPqi42q8rhiw+v5PB-87MTdAFb+22nGZ4sEGdYg@mail.gmail.com>
Message-ID: <CAD=FV=V-guTEPqi42q8rhiw+v5PB-87MTdAFb+22nGZ4sEGdYg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mmc: sdio: Move comment about re-initialization to mmc_sdio_reinit_card()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 18, 2019 at 8:35 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The comment in mmc_sdio_power_restore() belongs in mmc_sdio_reinit_card(),
> which was created during a previous commit that re-factored some code. Fix
> this by moving the comment into mmc_sdio_reinit_card().
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio.c | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
