Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1B13971
	for <lists+linux-mmc@lfdr.de>; Sat,  4 May 2019 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEDLIw (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Sat, 4 May 2019 07:08:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35813 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEDLIw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 May 2019 07:08:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so4023564pgs.2
        for <linux-mmc@vger.kernel.org>; Sat, 04 May 2019 04:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=cqqa4q99/Lv2tw6JiglAaYjYanVFG3g06d0Zz6ZhSGM=;
        b=D7rh4aWEbmKRooLNT2RaVQiPzhgbFPfegyT8eHJHLJxRfeif6rpsePwD/AzuDnHQQS
         YgHm8c6YTzW/iiVz6PqwyOgZStXEaFlXkqf1P2K0639Mio2AU3kQOqoUAFYqSKSG1KNd
         sGOROT1qizzQbKh3shjryjolRYslvzTWXuqkxF1rQ5pS9VM7SCkTKZSb5LQdhAohq9mZ
         DexMMLocklqrenMZQlXcWAdq+KzzK9I5blfUQv6uWAVDC5wT5LM2pBMw8EXYfOFme2KS
         Q034SQ//FgLWSnEhcGhxJ/QsRqMvO01tB9yr6PvD0nf7skgK/udEuR/ePXhD3EnkpnMu
         0TKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=cqqa4q99/Lv2tw6JiglAaYjYanVFG3g06d0Zz6ZhSGM=;
        b=IpfZTHRluMHLhtk4EERe0aI6OpxWAo+HJgKiLMi2QWX/Hj/NTuPzUWYVe38iCq3Qqr
         U/Mqh5FgoxivIjdZUQEXqfJqtX/LM02QkQeuo5SlskW2fT/+lU+5xM2ygJDEjmXgmmXk
         1nYwdFUbfUBnt99OZ+rxvbvlv39SVZdjJoagFCPX2JO2I7iBYJyJCjd35yUAeN6eOia2
         QDXZ25exU8zhsZ1V/eE9/yg7S+s/7HkeC1PPfdJ1aCL5YcQqStZvQx2qDrD01Sr5hnVq
         MmLcAkuIvfM7L5kbIAm7VoN4e+usIH2BqUY3Gq62HIqdNWbJ1x+JS3CxKw4ObRNVIQUT
         Q1jw==
X-Gm-Message-State: APjAAAWbapdhAdKKFurmfyXiJw82vMOo75s6idEJuQ5vXnB4Bi74J+4Z
        WrW58XM8u0yNDdYbHKwfA3o=
X-Google-Smtp-Source: APXvYqzu5jA6mRAw+hpvHB2DkRbpyge5mxpnDM88hHtF4+YQugXEU9fKVtV/2Vuq7SVU/EFCgZyLoA==
X-Received: by 2002:a63:fd49:: with SMTP id m9mr17739765pgj.16.1556968131602;
        Sat, 04 May 2019 04:08:51 -0700 (PDT)
Received: from localhost.localdomain ([203.192.210.82])
        by smtp.gmail.com with ESMTPSA id k67sm6198260pfb.44.2019.05.04.04.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 May 2019 04:08:50 -0700 (PDT)
From:   Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
To:     Oleksij Rempel <linux@rempel-privat.de>,
        Lukas Wunner <lukas@wunner.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] mmc: alcor: Drop pointer to mmc_host from alcor_sdmmc_host
Date:   Sat,  4 May 2019 16:38:43 +0530
Message-Id: <1556968123-6264-1-git-send-email-kamlesh.gurudasani@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556776696-19300-1-git-send-email-kamlesh.gurudasani@gmail.com>
References: <1556776696-19300-1-git-send-email-kamlesh.gurudasani@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Daniel, Ulf,

Similar patch was accepted for BCM2835 MMC host driver on feb 3. 
https://patchwork.kernel.org/patch/10794583/ 
Please review, if it gets accepted I can make changes in the remaining drivers also.

Regards,
Kamlesh
