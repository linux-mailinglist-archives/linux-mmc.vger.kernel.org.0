Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEF934D1A9
	for <lists+linux-mmc@lfdr.de>; Mon, 29 Mar 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhC2NrK (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 29 Mar 2021 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhC2NrC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Mar 2021 09:47:02 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491EC061574
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 06:47:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o126so18586189lfa.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Mar 2021 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53xSj5DfXd9H1GpbknrIL485EwLdmQCgbXSAs/QT+/o=;
        b=yhPWMG13vhBx59H2VpJc5BK8cY4/JSTE4JcwVrJ+ZIjc4fA911utIUFjfl5tIzLq9R
         qSfY+azU5HU3eE/ivaeU6HdLvDQGMnm2jBcupDt95pGHdfk1ZLCrY7g4kZYAEc22Pgtt
         1UIhdAr0aERFI/nNcSGaOsQ8y2EgROOz85LpRyvAZkQZQGTlIwu8+7UdEGXUOZX2rE6g
         pEo3efviOuF+PXy+3kLaX3SMNQtB32DCX1BFNfDRHYzmWO1YX99xPNkOylJWee+UVa6m
         1jkomPURjQile+F4rkWZZMoYX1oPwop3LBFUwA1hOU+4kHE4AEiArUXJmVY59ROOZPvf
         PbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53xSj5DfXd9H1GpbknrIL485EwLdmQCgbXSAs/QT+/o=;
        b=UxFJ/F66P/Icx4wYAMQcSDHhnboc2Lx4bF2O+NCZ6cuq1uppsu6KobxQU4ZAxab2a5
         boMex1oe5yxYozeCqMjl1HGDUGBo2nnVgkO8arn29mmbHgLM41Xwm/aOLZcpel4OdUcS
         rtgrucyEsTHo1dI1zxDIiqvJGxOuMg8zFE8dGG9YnK01qdu2yRCEGA6Cogof27W7tOlR
         EMDeNFogDs1GjKMJgRol/lg4Nv5pYVu04RVwHN/EgBsxAio7CLkNs5qMONrp2xEDHoKw
         3/T6VffdTmTu1Rz6oPS1O2Qy15Ho0Kqxs9cBZ5LoS0qI84Xtrh1xUkJlTw3FqUIkfnqC
         /G9w==
X-Gm-Message-State: AOAM530SN9m7Vm+HDbfuPDAN9Kr6q2qsLIFnncnCDQ5tnIkadmqzO/WE
        n6bfSTffzG98wG4lqRI2lVEpfldVm6hc/6oJ6bSEAg==
X-Google-Smtp-Source: ABdhPJx6Axg9ofLpquCRIjMCOhfnJFBxvPAErT/NqyJYw09/tE2YGisLWKD/dFqP42J60embz/z2dwtQ7xqxrQLa49s=
X-Received: by 2002:a19:548:: with SMTP id 69mr16333313lff.465.1617025620232;
 Mon, 29 Mar 2021 06:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-2-brad@pensando.io>
In-Reply-To: <20210329015938.20316-2-brad@pensando.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Mar 2021 15:46:48 +0200
Message-ID: <CACRpkda2XvgoLENQbh2dFVQqgm=fxF4=ZwG-T-DBmLjLWxABCA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 29, 2021 at 3:59 AM Brad Larson <brad@pensando.io> wrote:

> This GPIO driver is for the Pensando Elba SoC which
> provides control of four chip selects on two SPI busses.
>
> Signed-off-by: Brad Larson <brad@pensando.io>

You have not addressed mine nor Andy's comments
on v1. Go back, read and reply, and rewrite.

Yours,
Linus Walleij
