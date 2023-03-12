Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86C96B6B15
	for <lists+linux-mmc@lfdr.de>; Sun, 12 Mar 2023 21:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCLU2h (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sun, 12 Mar 2023 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCLU2e (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 16:28:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B034C1B
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:28:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k10so40792019edk.13
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678652912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2J/3a1IUaezXRt8cT97feyTSCzihsk5DrzTrn45/F0=;
        b=JUpqysnXzPDgr43xph6NOGrfHrK3hRBSbcoJmKlMZGRDgz34bhdPORL1rTk5v6vDuh
         o0uKboTtDj37hQp+w7kIxlt6GDhEoW4Yg2gJYl1k+d2FOPfZx0eJJdffcbDGlQs4uDVx
         n31eTA/4bK9Wo7RXr5gVahhx78cAPjHxVt7c8/9n+SUawkBee/5BPkCl2n2v0jPiXp/z
         GGllzt7sWFJXAS9bhl+nWe7hR0XeE4JIIZfSACTaS0G+EDs/CfeNd74gBwFBI8DS7AdA
         q9Y3OHuc6Z5T9cVot7VrKfpjqhllDyvRTuyABN0DCqSPUwy3VvXy+sYvTcsw7yNrbAL2
         dr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2J/3a1IUaezXRt8cT97feyTSCzihsk5DrzTrn45/F0=;
        b=yZ+ACyOIT/paKXGailSZmQ9KRHJuhFJTvYDrC/4w3W/CLyzBr5FhW6ZWCjCe+Ctiko
         quovU94xpeAdvpOVfXOd7uAiecjaH2jkqxSHRlBAWb6cDJ13TUpcxBbXCiP60D7L5P5X
         FIek0dDZZu6qTDHsLbubA+LVWh2Dc6GqxTqq9aJ1EvNnCBvm4hQwLPa9/r+5dvry6X+G
         WMSPzdnZXmlJWbNiNV8XaYGYujef8wP19xAsjbILHQfIfU1e2JDDBx3iuvoB4/dn3DA/
         lQ0AmFE5BWJAIvPpaTnLWE+jEsVKe88RtSd5o6DW4kz35jdrwI8uRvvrAnKAQMJFU1vE
         4VRg==
X-Gm-Message-State: AO0yUKUCHewqzb39Ha4YoI6SqPzYVJ9TCMSoxJBlmnIfvGFO3YiMSqlH
        17AEhyMmtSBsrPMEgcYZSf+Y6sjDCUk/Y0LYHDI=
X-Google-Smtp-Source: AK7set93CmoSxc8XZ2D8bTosdl3KJ/YMl/BkXjYrsCPN0sT+HwveYVPnKlpKaUK0A+hjoilnAd7BihLVcNFrQayDwF4=
X-Received: by 2002:a50:9fa5:0:b0:4fb:e0e8:5140 with SMTP id
 c34-20020a509fa5000000b004fbe0e85140mr984123edf.6.1678652911615; Sun, 12 Mar
 2023 13:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com> <2ceb62da-07e6-bafc-c29e-13cc1cdde93a@gmail.com>
In-Reply-To: <2ceb62da-07e6-bafc-c29e-13cc1cdde93a@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Mar 2023 21:28:20 +0100
Message-ID: <CAFBinCA-f5aC0A33bnEejvrnrxPY-qGy7QDSrVHKCDxvv8O9zA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: meson-gx: use new helpers mmc_regulator_enable/disable_vqmmc
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Mar 11, 2023 at 11:41=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> Use new helpers mmc_regulator_enable/disable_vqmmc to simplify
> the code.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
