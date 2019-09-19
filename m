Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830B9B8395
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Sep 2019 23:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390391AbfISVm4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 19 Sep 2019 17:42:56 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:35267 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391441AbfISVmx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2019 17:42:53 -0400
Received: by mail-ed1-f53.google.com with SMTP id v8so4558439eds.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2019 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPXt1oW5DrO8Oz/+ZgQWbhpdLKiDcFjVs0zf8G0Ey+0=;
        b=F7rY2woNh5IcAn5OYZoXJ8RCbJxd2yqyiH4M8f85UZWHRWoLW8sjxdFct2ymo6ZVkB
         dVMXB2tC3uNyvgUUwJpyEiyqOMCXqRWH+hjIvcN+KTmU8ILI1vlk47akitpXVlldhj5e
         orWDGJNZiJu9frflXNbP/9bBuZWkaRCZZLtD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPXt1oW5DrO8Oz/+ZgQWbhpdLKiDcFjVs0zf8G0Ey+0=;
        b=olfWcdbwm8rYqTssW/IuyypzomE2kE2+ddTvz+JXkow4v3wyTd9VSZRkcoxSj7RDa4
         55+4Hva2gs0wLvwWB1LtmXHiozsG4AJqs4GX8+6ZnRIonZ65ee2emJ/i1UHFyZiGGdsJ
         agP4+a6TOHHkPM87b5/7Xu3WmnbYErHLz0T9NvGZVSfRkY/izzLptQThscYa+ydbhcoU
         hFUGEcLbdU/RnGOMnvHDrNmQUvp0865x5/9vtyHzpk12OfuZPQ1xZ7VVLYGFfnzmY1Ui
         Igvuc9pRdV9yT+py0y4QsLl9kMEzdvOos9DZpEnxfHUpfZxZgt5xyAcGgEFWnYj0dWpd
         o/Ng==
X-Gm-Message-State: APjAAAUmfgN8sKYzsT3c2xWopSWZeY7q1e+KLxqOjJeVPnXk4XrRtirJ
        4rtzekaaSRwzNBAUap+JpQTQenKh1Gc=
X-Google-Smtp-Source: APXvYqwTEQxcqyXlmPW5K5qLSb+nVUcB34NQN0bOMjWkbeyQTknpPyxR4hcJxFlZOfY80H3m8+1fOw==
X-Received: by 2002:a17:906:d050:: with SMTP id bo16mr16616961ejb.146.1568929371600;
        Thu, 19 Sep 2019 14:42:51 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id w16sm1872214edd.93.2019.09.19.14.42.51
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2019 14:42:51 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id r5so4617886wrm.12
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2019 14:42:51 -0700 (PDT)
X-Received: by 2002:a5d:4689:: with SMTP id u9mr8650228wrq.78.1568929370634;
 Thu, 19 Sep 2019 14:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190904164625.236978-1-rrangel@chromium.org>
In-Reply-To: <20190904164625.236978-1-rrangel@chromium.org>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Thu, 19 Sep 2019 15:42:39 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DjvU8iqG=-UTjQgb7m-ayBhoAtRP_mXY4WmjWs_kqZKQ@mail.gmail.com>
Message-ID: <CAHQZ30DjvU8iqG=-UTjQgb7m-ayBhoAtRP_mXY4WmjWs_kqZKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Check card status after reset
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Pinging the patch set to make sure it's not forgotten :)

Thanks
